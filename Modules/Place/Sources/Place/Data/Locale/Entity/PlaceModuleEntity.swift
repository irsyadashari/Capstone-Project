//
//  PlaceModuleEntity.swift
//  
//
//  Created by Irsyad Ashari on 05/01/21.
//

import Foundation
import RealmSwift

public class PlaceModuleEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var like: Int = 0
    @objc dynamic var image: String = ""
    @objc dynamic var isFavorite: Bool = false
    
    public override static func primaryKey() -> String? {
        return "id"
    }
}