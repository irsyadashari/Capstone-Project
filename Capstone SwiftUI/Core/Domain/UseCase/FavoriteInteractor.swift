//
//  FavoriteInteractor.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 13/11/20.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    func getFavoritePlaces() -> AnyPublisher<[PlaceModel], Error>
}

class FavoriteInteractor: FavoriteUseCase{

    private let favoriteRepository: FavoritePlaceRepositoryProtocol
    
    required init (repository: FavoritePlaceRepositoryProtocol){
        self.favoriteRepository = repository
    }
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceModel], Error> {
        return favoriteRepository.getFavoritePlaces()
    }
    
}

