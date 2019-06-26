//
//  ProductsRealmStore.swift
//  SearchFilter
//
//  Created by Jimmy Wu on 20/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import RealmSwift

protocol ProductsStorage {
    func save(products: [Product])
    func getProducts() -> [Product]
    func write(writeBlock: () -> Void)
}

class ProductsRealmStorage: RealmStorage, ProductsStorage {

    func save(products: [Product]) {
        try! realm.write {
            realm.add(products, update: .modified)
        }
    }
    
    func getProducts() -> [Product] {
        return Array(realm.objects(Product.self))
    }
    
    func write(writeBlock: () -> Void) {
        do {
            try realm.write(writeBlock)
        } catch {
            debugPrint("fail to realm write")
        }
    }
}
