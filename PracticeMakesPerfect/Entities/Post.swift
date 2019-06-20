//
//  Post.swift
//  PracticeMakesPerfect
//
//  Created by Jimmy Wu on 19/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import RealmSwift

class Post: Object {
    
    dynamic var id = 0
    dynamic var userId = 0
    dynamic var title = ""
    dynamic var body = ""
    dynamic var imageURL = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }

}
