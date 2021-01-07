//
//  File.swift
//  
//
//  Created by Irsyad Ashari on 05/01/21.
//

import Foundation
import Core
import RealmSwift
import Combine

public struct GetPlacesLocaleDataSource: LocaleDataSource {
   
    public typealias Request = Any
    public typealias Response = PlaceModuleEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: Any?) -> AnyPublisher<[PlaceModuleEntity], Error> {
        return Future<[PlaceModuleEntity], Error> { completion in
            let places: Results<PlaceModuleEntity> = {
                _realm.objects(PlaceModuleEntity.self)
                    .sorted(byKeyPath: "name", ascending: true)
            }()
            completion(.success(places.toArray(ofType: PlaceModuleEntity.self)))
            
        }.eraseToAnyPublisher()
    }
        
    public func add(entities: [PlaceModuleEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    for place in entities {
                        _realm.add(place, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }
            
        }.eraseToAnyPublisher()
    }
    
    public func get(id: Int) -> AnyPublisher<PlaceModuleEntity, Error> {
        fatalError()
    }
    
    public func update(id: Int, entity: PlaceModuleEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}
