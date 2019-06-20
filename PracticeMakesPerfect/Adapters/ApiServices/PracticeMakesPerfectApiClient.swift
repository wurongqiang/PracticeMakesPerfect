
//
//  PracticeMakesPerfectClient.swift
//  PracticeMakesPerfect
//
//  Created by Jimmy Wu on 19/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

protocol PracticeMakesPerfectApiClient {
    func getString(path: String, headers: [String: String]) -> Observable<(Bool, String)>
}

class PracticeMakesPerfectApiClientImpl: PracticeMakesPerfectApiClient {
    
    private let hostProduction = "https://www.sweetescape.com/api/v1/"
    
    func getString(path: String, headers: [String : String]) -> Observable<(Bool, String)> {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
//        let manager = SessionManager.default
        
        return .never()
    }
    
}
