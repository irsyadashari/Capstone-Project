//
//  LocaleDataSource.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 11/11/20.
//

import Foundation
import RealmSwift

protocol LocaleDataSourceProtocol: class{
    
    func getPlaces(result: @escaping (Result<[PlaceEntity], DatabaseError>) -> Void)
    func addPlaces(
        from places: [PlaceEntity],
        result: @escaping (Result<Bool, DatabaseError>) -> Void
    )
}

final class LocaleDataSource: NSObject {
    
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
        
       
    }
    static let sharedInstance: (Realm?) -> LocaleDataSource = {
        realmDatabase in return LocaleDataSource(realm: realmDatabase)
    }
    
}

extension LocaleDataSource: LocaleDataSourceProtocol{
    
    func getPlaces(result: @escaping (Result<[PlaceEntity], DatabaseError>) -> Void) {
        
        if let realm = realm{
            let places: Results<PlaceEntity> = {
                realm.objects(PlaceEntity.self)
                    .sorted(byKeyPath: "name", ascending: true)
            }()
            
            result(.success(places.toArray(ofType: PlaceEntity.self)))
        }else{
            result(.failure(.invalidInstance))
        }
        
    }
    
    func addPlaces(
        from places: [PlaceEntity],
        result: @escaping (Result<Bool, DatabaseError>) -> Void) {
        
        if let realm = realm {
            do {
                try realm.write {
                    for place in places {
                        realm.add(place, update: .all)
                    }
                    result(.success(true))
                }
            } catch {
                result(.failure(.requestFailed))
            }
        } else {
            result(.failure(.invalidInstance))
        }
        
    }
    
}

extension Results{
    
    func toArray<T>(ofType: T.Type) -> [T]{
        var array = [T]()
        for index in 0 ..< count{
            if let result = self[index] as? T{
                array.append(result)
            }
        }
        return array
    }
    
}
