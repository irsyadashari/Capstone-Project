//
//  LocaleDataSource.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 11/11/20.
//

import RealmSwift
import Combine
import Foundation

protocol LocaleDataSourceProtocol: class {
    
    func getPlaces() -> AnyPublisher<[PlaceEntity], Error>
    func addPlaces(from places: [PlaceEntity]) -> AnyPublisher<Bool, Error>
    func toggleFavorite(place: PlaceModel) -> AnyPublisher<PlaceModel, Error>
}

final class LocaleDataSource: NSObject {
    
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
      return LocaleDataSource(realm: realmDatabase)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    
    func getPlaces() -> AnyPublisher<[PlaceEntity], Error> {
        
        return Future<[PlaceEntity], Error> { completion in
            
            if let realm = self.realm {
                let places: Results<PlaceEntity> = {
                    realm.objects(PlaceEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(.success(places.toArray(ofType: PlaceEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addPlaces(from places: [PlaceEntity]) -> AnyPublisher<Bool, Error> {
        
        return Future<Bool, Error> { completion in
            
            if let realm = self.realm {
                do {
                    try realm.write {
                        for place in places {
                            realm.add(place, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func toggleFavorite(place: PlaceModel) -> AnyPublisher<PlaceModel, Error> {
        
        return Future<PlaceModel, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.create(
                            PlaceEntity.self,
                            value: ["id": place.id, "isFavorite": !place.isFavorite],
                            update: .modified)
                        completion(.success(place))
                    }
                } catch let error {
                    // Handle error
                    completion(.failure(DatabaseError.invalidInstance))
                    print(error.localizedDescription)
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
