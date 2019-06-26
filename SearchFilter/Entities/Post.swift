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
    
    @objc dynamic var id = 0
    @objc dynamic var userId = 0
    @objc dynamic var title = ""
    @objc dynamic var body = ""
    @objc dynamic var imageURL = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }

}
