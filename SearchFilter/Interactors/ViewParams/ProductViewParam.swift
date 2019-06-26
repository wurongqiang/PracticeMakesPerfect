//
//  ProductViewParam.swift
//  SearchFilter
//
//  Created by Jimmy Wu on 19/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation

class ProductViewParam {
    
    var id = 0
    var name = ""
    var price = ""
    var imageURL: URL?
    
    init() {}
    
    init(id: Int, name: String, price: String, imageURL: URL?) {
        self.id = id
        self.name = name
        self.price = price
        self.imageURL = imageURL
    }
 
    static func create(products: [Product]) -> [ProductViewParam] {
        var productViewParams = [ProductViewParam]()
        
        products.forEach {
            productViewParams.append(ProductViewParam.create(product: $0))
        }
        
        return productViewParams
    }
    
    static func create(product: Product) -> ProductViewParam {
        return ProductViewParam(id: product.id, name: product.name, price: product.price, imageURL: URL(string: product.imageURL))
    }
}
