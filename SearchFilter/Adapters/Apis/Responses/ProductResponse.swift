//
//  ProductResponse.swift
//  SearchFilter
//
//  Created by Jimmy Wu on 20/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductResponse: Mappable {
    
    var id = 0
    var name = ""
    var price = ""
    var imageURL = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        price <- map["price"]
        imageURL <- map["image_uri"]
    }
    
    func toProduct() -> Product {
        let product = Product()
        product.id = id
        product.name = name
        product.price = price
        product.imageURL = imageURL
        return product
    }
}

class ProductResultResponse: Mappable {
    var productResult = [ProductResponse]()
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        productResult <- map["data"]
    }
    
    func toProducts() -> [Product] {
        var products = [Product]()
        productResult.forEach { productResponse in
            products.append(productResponse.toProduct())
        }
        return products
    }
}

