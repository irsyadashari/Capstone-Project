//
//  PlaceEntity.swift
//  VacationSite
//
//  Created by Irsyad Ashari on 05/11/20.
//

import RealmSwift

class PlaceEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var like: Int = 0
    @objc dynamic var image: String = ""
    @objc dynamic var isFavorite: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
