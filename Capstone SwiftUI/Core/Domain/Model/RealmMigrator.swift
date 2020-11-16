//
//  RealmMigrator.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 16/11/20.
//

import RealmSwift

enum RealmMigrator{
    
    static private func migrationBlock(
        migration: Migration,
        oldSchemaVersion: UInt64
    ){
        if oldSchemaVersion < 1 {
            migration.enumerateObjects(ofType: PlaceEntity.className()){ _ ,
                newObject in
                newObject?["isFavorite"] = false
            }
        }
    }
    
    static func setDefaultConfiguration() {
        // 1
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: migrationBlock)
        // 2
        Realm.Configuration.defaultConfiguration = config
    }

    
}
