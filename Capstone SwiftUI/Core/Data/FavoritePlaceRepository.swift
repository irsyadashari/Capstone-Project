//
//  FavoritePlaceRepository.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 13/11/20.
//

import Foundation
import Combine

protocol FavoritePlaceRepositoryProtocol {
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceModel], Error>
}

final class FavoritePlaceRepository: NSObject{
    
    typealias FavoritePlaceInstance = (FavoriteDataSource) -> FavoritePlaceRepository
    
    fileprivate let locale: FavoriteDataSource
    private init(locale: FavoriteDataSource) {
        self.locale = locale
    }
    static let favoriteSharedInstance: FavoritePlaceInstance = { localeRepo in
        return FavoritePlaceRepository(locale: localeRepo)
    }
    
}

extension FavoritePlaceRepository: FavoritePlaceRepositoryProtocol{
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceModel], Error>{
        
        return self.locale.getFavoritePlaces()
            .flatMap{ result -> AnyPublisher<[PlaceModel], Error> in
                
                return self.locale.getFavoritePlaces()
                    .map { PlaceMapper.mapPlaceEntitiesToDomains(input: $0) }
                    .eraseToAnyPublisher()
                
            }.eraseToAnyPublisher()
        
    }
    
    
}
