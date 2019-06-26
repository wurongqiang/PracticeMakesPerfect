//
//  DisplayProducts.swift
//  SearchFilter
//
//  Created by Jimmy Wu on 19/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import RxSwift

protocol DisplayProducts {
    func searchProduct(query: String, priceMin: Int, priceMax: Int, wholeSale: Bool, start: Int, rows: Int) -> Observable<[ProductViewParam]>
}

class DisplayProductsImpl: DisplayProducts {
    
    private let productApi: ProductApi
    private let productsStorage: ProductsStorage
    private let disposeBag = DisposeBag()
    
    init(productApi: ProductApi, productStorage: ProductsStorage) {
        self.productApi = productApi
        self.productsStorage = productStorage
    }
    
    func searchProduct(query: String, priceMin: Int, priceMax: Int, wholeSale: Bool, start: Int, rows: Int) -> Observable<[ProductViewParam]> {
        let productsFromCache = getAllProductsFromCache()
        let productsFromServer = getAllProductsFromServer(query: query, priceMin: priceMin, priceMax: priceMax, wholeSale: wholeSale, start: start, rows: rows)
        
        return Observable.of(productsFromCache, productsFromServer).merge()
    }
    
    private func getAllProductsFromCache() -> Observable<[ProductViewParam]> {
        let products = productsStorage.getProducts()
        guard !products.isEmpty else {
            return Observable.empty()
        }
        let productViewParams = ProductViewParam.create(products: products)
        
        return .just(productViewParams)
    }
    
    private func getAllProductsFromServer(query: String, priceMin: Int, priceMax: Int, wholeSale: Bool, start: Int, rows: Int) -> Observable<[ProductViewParam]> {
        return productApi.searchProduct(query: query, priceMin: priceMin, priceMax: priceMax, wholeSale: wholeSale, start: start, rows: rows)
            .map { [weak self] products in
                guard let weakSelf = self else { return [ProductViewParam]() }
                weakSelf.productsStorage.save(products: products)
                return ProductViewParam.create(products: products)
            }
    }
    
}
