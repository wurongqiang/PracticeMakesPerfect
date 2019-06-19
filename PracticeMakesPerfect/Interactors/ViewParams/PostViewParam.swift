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
    
}
