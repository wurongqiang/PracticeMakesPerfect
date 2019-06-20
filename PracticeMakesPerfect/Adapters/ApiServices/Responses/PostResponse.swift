//
//  PostResponse.swift
//  PracticeMakesPerfect
//
//  Created by Jimmy Wu on 20/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import ObjectMapper

class PostResponse: Mappable {
    
    var id = 0
    var userId = 0
    var title = ""
    var body = ""
    var imageURL = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        userId <- map["user_id"]
        title <- map["title"]
        body <- map["body"]
    }
    
    func toPost() -> Post {
        let post = Post()
        post.id = id
        post.userId = userId
        post.title = title
        post.body = body
        post.imageURL = imageURL
        return post
    }
}

class PostResultResponse: Mappable {
    var postResult = [PostResponse]()
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        postResult <- map["result"]
    }
    
    func toPosts() -> [Post] {
        var posts = [Post]()
        postResult.forEach { postResponse in
            posts.append(postResponse.toPost())
        }
        return posts
    }
}

