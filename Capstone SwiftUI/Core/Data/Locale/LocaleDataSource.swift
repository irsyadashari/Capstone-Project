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
    func getPlace(by idPlace: Int) -> AnyPublisher<PlaceEntity, Error>
    func addPlaces(from places: [PlaceEntity]) -> AnyPublisher<Bool, Error>
    func getFavoritePlaces() -> AnyPublisher<[PlaceEntity], Error>
    func updateFavoritePlace(by idPlace: Int) -> AnyPublisher<PlaceEntity, Error>
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
    
    func getPlace(by idPlace: Int) -> AnyPublisher<PlaceEntity, Error> {
        return Future<PlaceEntity, Error> { completion in
            if let realm = self.realm {
                let places: Results<PlaceEntity> = {
                    realm.objects(PlaceEntity.self)
                        .filter("id = '\(idPlace)'")
                }()
                
                guard let place = places.first else {
                    completion(.failure(DatabaseError.requestFailed))
                    return
                }
                
                completion(.success(place))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceEntity], Error> {
        
        return Future<[PlaceEntity], Error> { completion in
            if let realm = self.realm {
                let placeEntities = {
                    realm.objects(PlaceEntity.self)
                        .filter("isFavorite = \(true)")
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(.success(placeEntities.toArray(ofType: PlaceEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func updateFavoritePlace(
        by idPlace: Int
    ) -> AnyPublisher<PlaceEntity, Error> {
        return Future<PlaceEntity, Error> { completion in
            if let realm = self.realm, let placeEntity = {
                realm.objects(PlaceEntity.self).filter("id = \(Int(idPlace))")
            }().first {
                do {
                    try realm.write {
                        placeEntity.setValue(!placeEntity.isFavorite, forKey: "isFavorite")
                    }
                    completion(.success(placeEntity))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                print(DatabaseError.invalidInstance)
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getPlaces() -> AnyPublisher<[PlaceEntity], Error> {
        
        return Future<[PlaceEntity], Error> { completion in
           
            if let realm = self.realm {
                let places: Results<PlaceEntity> = {
                    realm.objects(PlaceEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                print(places)
                completion(.success(places.toArray(ofType: PlaceEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addPlaces(
        from places: [PlaceEntity]
    ) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            print("suksek menambahkan data ke database")
            if let realm = self.realm {
                do {
                    try realm.write {
                        for place in places {
                            print("Place Object\n")
                            print("\(place)")
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
