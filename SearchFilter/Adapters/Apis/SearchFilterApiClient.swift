
//
//  SearchFilterClient.swift
//  SearchFilter
//
//  Created by Jimmy Wu on 19/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire


protocol SearchFilterApiClient {
    func getString(path: String, parameters: [String: Any], headers: [String: String]) -> Observable<(Bool, String)>
}

class SearchFilterApiClientImpl: SearchFilterApiClient {
    
    private let host = "https://ace.tokopedia.com/search/v2.5/"
    
    func getString(path: String, parameters: [String: Any], headers: [String: String]) -> Observable<(Bool, String)> {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let manager = SessionManager.default
        
        return manager.rx.request(.get, createURL(path: path), parameters: parameters, headers: populateHeaders(dict: headers))
            .flatMap { alamofireRequest in
                alamofireRequest.rx.responseString()
            }
            .do(onNext: { (response, string) in
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
            },
                onError: { _ in
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
            },
                onCompleted: {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
            .map { (response, string) in
                return (response.statusCode == 200, string)
        }
    }
    
    private func createURL(path: String) -> String {
        return host + path
    }
    
    private func populateHeaders(
        dict: [String:String]? = nil) -> [String:String] {
        var headers = [String:String]()
        headers["Authorization"] = ""
        
        if let dict = dict {
            for (k, v) in dict where !k.isEmpty {
                headers[k] = v
            }
        }
        
        return headers
    }
    
}
