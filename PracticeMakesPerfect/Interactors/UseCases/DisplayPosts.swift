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
    
    func getPosts() -> Observable<[PostViewParam]> {
        var posts = [PostViewParam]()
        
        posts.append(PostViewParam.init(id: 1, userId: 101, title: "Post pertama", body: "Body post pertama"))
        posts.append(PostViewParam.init(id: 2, userId: 102, title: "Post kedua", body: "Body post kedua"))
        posts.append(PostViewParam.init(id: 3, userId: 103, title: "Post ketiga", body: "Body post ketiga"))
        
        return .just(posts)
    }
    
}
