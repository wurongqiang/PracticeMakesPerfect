//
//  Product.swift
//  SearchFilter
//
//  Created by Jimmy Wu on 19/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import RealmSwift

class Product: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var price = ""
    @objc dynamic var imageURL = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }

}
