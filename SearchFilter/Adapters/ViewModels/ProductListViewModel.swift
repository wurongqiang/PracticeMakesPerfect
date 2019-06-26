//
//  ListViewModel.swift
//  SearchFilter
//
//  Created by Jimmy Wu on 19/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import RxSwift

class ProductListViewModel {
    
    private let displayProducts: DisplayProducts
    private let disposeBag = DisposeBag()
    private (set) var productViewParams = [ProductViewParam]()
    
    private let eventProductsLoaded = PublishSubject<Void>()
    
    var rxEventProductsLoaded: Observable<Void> {
        return eventProductsLoaded
    }
    
    init(displayProducts: DisplayProducts) {
        self.displayProducts = displayProducts
    }
    
    func viewLoad() {
        loadProducts()
    }
    
    private func loadProducts() {
        displayProducts.searchProduct(query: "samsung", priceMin: 10000, priceMax: 100000, wholeSale: true, start: 0, rows: 10).subscribe(onNext: { [weak self] products in
            guard let weakSelf = self else { return }
            weakSelf.productViewParams = products
            weakSelf.eventProductsLoaded.onNext(())
        }).disposed(by: disposeBag)
    }
}
