//
//  ProductApiImpl.swift
//  SearchFilter
//
//  Created by Jimmy Wu on 20/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

protocol ProductApi {
    func searchProduct(query: String, priceMin: Int, priceMax: Int, wholeSale: Bool, start: Int, rows: Int) -> Observable<[Product]>
}

class ProductApiImpl: ProductApi {
    
    let practiceMakesPerfectApiClient: SearchFilterApiClient
    
    init(practiceMakesPerfectApiClient: SearchFilterApiClient) {
        self.practiceMakesPerfectApiClient = practiceMakesPerfectApiClient
    }
    
    func searchProduct(query: String, priceMin: Int, priceMax: Int, wholeSale: Bool, start: Int, rows: Int) -> Observable<[Product]> {
        var parameters = [String: Any]()
        parameters["q"] = query
        parameters["pmin"] = priceMin
        parameters["pmax"] = priceMax
        parameters["wholeSale"] = wholeSale
        parameters["start"] = start
        parameters["rows"] = rows
        return practiceMakesPerfectApiClient.getString(path: "product", parameters: parameters, headers: ["":""])
            .filter { (success, _) in
                return success
            }
            .map { (_, jsonString) in
                Mapper<ProductResultResponse>().map(JSONString: jsonString)?.toProducts() ?? [Product]()
            }
    }
    
}
