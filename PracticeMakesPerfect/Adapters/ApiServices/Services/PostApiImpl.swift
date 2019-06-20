//
//  PostApiImpl.swift
//  PracticeMakesPerfect
//
//  Created by Jimmy Wu on 20/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

protocol PostApi {
    func getAllPosts() -> Observable<[Post]>
}

class PostApiImpl: PostApi {
    
    let practiceMakesPerfectApiClient: PracticeMakesPerfectApiClient
    
    init(practiceMakesPerfectApiClient: PracticeMakesPerfectApiClient) {
        self.practiceMakesPerfectApiClient = practiceMakesPerfectApiClient
    }
    
    func getAllPosts() -> Observable<[Post]> {
        return practiceMakesPerfectApiClient.getString(path: "posts", headers: ["":""])
            .filter { (success, _) in
                return success
            }
            .map { (_, jsonString) in
                Mapper<PostResultResponse>().map(JSONString: jsonString)?.toPosts() ?? [Post]()
            }
    }
    
}
