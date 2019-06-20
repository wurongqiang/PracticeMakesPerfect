//
//  PostViewParam.swift
//  PracticeMakesPerfect
//
//  Created by Jimmy Wu on 19/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation

class PostViewParam {
    
    var id = 0
    var userId = 0
    var title = ""
    var body = ""
    var image = URL(string: "")
    
    init(id: Int, userId: Int, title: String, body: String, image: URL) {
        self.id = id
        self.userId = userId
        self.title = title
        self.body = body
        self.image = image
    }
 
    static func create(posts: [Post]) -> [PostViewParam] {
        var postViewParams = [PostViewParam]()
        
        posts.forEach {
            postViewParams.append(PostViewParam.create(post: $0))
        }
        
        return postViewParams
    }
    
    static func create(post: Post) -> PostViewParam {
        let randomImages = ["https://instagram.fcgk7-1.fna.fbcdn.net/vp/5302f0076498f732a15434de139df574/5DC70068/t51.2885-19/s150x150/15801886_1562521650427820_7007391726432157696_a.jpg?_nc_ht=instagram.fcgk7-1.fna.fbcdn.net&_nc_cat=108", "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Big_%26_Small_Pumkins.JPG/800px-Big_%26_Small_Pumkins.JPG", "https://images-na.ssl-images-amazon.com/images/I/71psZ8E0AOL._SL1500_.jpg", "https://hellosehat.com/wp-content/uploads/2018/03/Mewaspadai-Infeksi-Listeria-pada-Rock-Melon-Australia-Ini-Bahayanya.jpg"]
        
        let imageURL = randomImages.randomElement()!
        
        return PostViewParam(id: post.id, userId: post.userId, title: post.title, body: post.body, image: URL(string: imageURL)!)
    }
}
