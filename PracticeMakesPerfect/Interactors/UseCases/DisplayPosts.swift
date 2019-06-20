//
//  DisplayPosts.swift
//  PracticeMakesPerfect
//
//  Created by Jimmy Wu on 19/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import RxSwift

protocol DisplayPosts {
    func getPosts() -> Observable<[PostViewParam]>
}

class DisplayPostsImpl: DisplayPosts {
    
    private let postApi: PostApi
    
    init(postApi: PostApi) {
        self.postApi = postApi
    }
    
    func getPosts() -> Observable<[PostViewParam]> {
        return postApi.getAllPosts()
            .map { posts in
                return PostViewParam.create(posts: posts)
            }
    }
    
}
