//
//  PostsRealmStore.swift
//  PracticeMakesPerfect
//
//  Created by Jimmy Wu on 20/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import RealmSwift

protocol PostsStorage {
    func save(posts: [Post])
    func getPosts() -> [Post]
    func write(writeBlock: () -> Void)
}

class PostsRealmStorage: RealmStorage, PostsStorage {

    func save(posts: [Post]) {
        try! realm.write {
            realm.add(posts, update: .modified)
        }
    }
    
    func getPosts() -> [Post] {
        return Array(realm.objects(Post.self))
    }
    
    func write(writeBlock: () -> Void) {
        do {
            try realm.write(writeBlock)
        } catch {
            debugPrint("fail to realm write")
        }
    }
}
