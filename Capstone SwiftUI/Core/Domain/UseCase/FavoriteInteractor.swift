//
//  FavoriteInteractor.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 06/01/21.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceModel], Error>
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: PlaceRepositoryProtocol
    
    required init(repository: PlaceRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceModel], Error> {
        return repository.getFavoritePlaces()
    }
    
}
