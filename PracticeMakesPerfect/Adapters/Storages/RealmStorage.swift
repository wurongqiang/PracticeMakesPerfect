//
//  RealmStore.swift
//  PracticeMakesPerfect
//
//  Created by Jimmy Wu on 20/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import RealmSwift

class RealmStorage {
    
    static let dbVersion: UInt64 = 1
    var realm: Realm
    
    init(inMemoryId: String? = nil) {
        if let inMemoryId = inMemoryId {
            realm = try! Realm(configuration:
                Realm.Configuration(inMemoryIdentifier: inMemoryId))
        } else {
            RealmStorage.initializeRealm()
            realm = try! Realm()
        }
    }
    
    class func initializeRealm() {
        let config = Realm.Configuration(
            schemaVersion: RealmStorage.dbVersion,
            
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < RealmStorage.dbVersion) {
                    //auto upgrade
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
    
    
    
    
}
