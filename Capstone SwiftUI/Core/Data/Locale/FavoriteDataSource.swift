//
//  FavoriteDataSource.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 11/11/20.
//

import Foundation
import RealmSwift
import Combine

protocol FavoriteDataSourceProtocol: class{
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceEntity], Error>
    func addFavoritePlaces(from favoritePlaces: [PlaceEntity]) -> AnyPublisher<Bool, Error>
    
}

final class FavoriteDataSource: NSObject {
    
    private let favRealm: Realm?
    private init(realm: Realm?) {
        self.favRealm = realm
    }
    static let favSharedInstance: (Realm?) -> FavoriteDataSource = {
        realmDatabase in return FavoriteDataSource(realm: realmDatabase)
    }
    
}

extension FavoriteDataSource: FavoriteDataSourceProtocol{
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceEntity], Error> {
        
        return Future<[PlaceEntity], Error>{ completion in
            
            if let realm = self.favRealm{
                let places: Results<PlaceEntity> = {
                    realm.objects(PlaceEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(.success(places.toArray(ofType: PlaceEntity.self)))
            }else{
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
        
    }
    
    func addFavoritePlaces(from favoritePlaces: [PlaceEntity]) -> AnyPublisher<Bool, Error> {
     
        return Future<Bool, Error> { completion in
            if let realm = self.favRealm {
                do {
                    try realm.write {
                        for place in favoritePlaces {
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
