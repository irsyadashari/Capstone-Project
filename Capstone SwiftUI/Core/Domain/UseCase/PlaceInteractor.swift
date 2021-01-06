//
//  PlaceInteractor.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 06/01/21.
//

import Foundation
import Combine

protocol PlaceUseCase {
    
    func getPlace() -> AnyPublisher<PlaceModel, Error>
    func getPlace() -> PlaceModel
    func updateFavoritePlace() -> AnyPublisher<PlaceModel, Error>
    
}

class PlaceInteractor: PlaceUseCase {
    
    private let repository: PlaceRepositoryProtocol
    private let place: PlaceModel
    
    required init(
        repository: PlaceRepositoryProtocol,
        place: PlaceModel
    ) {
        self.repository = repository
        self.place = place
    }
    
    func getPlace() -> AnyPublisher<PlaceModel, Error> {
        return repository.getPlace(by: place.id)
    }
    
    func getPlace() -> PlaceModel {
        return place
    }
    
    func updateFavoritePlace() -> AnyPublisher<PlaceModel, Error> {
        return repository.updateFavoritePlace(by: place.id)
    }
}

