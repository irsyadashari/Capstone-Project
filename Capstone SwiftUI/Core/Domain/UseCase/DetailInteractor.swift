//
//  DetailInteractor.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 11/11/20.

import Foundation
import Combine

protocol DetailUseCase {
    
    func getPlace() -> PlaceModel
    func updateFavoritePlace() -> AnyPublisher<PlaceEntity, Error>
}

class DetailInteractor: DetailUseCase {
   
    private let repository: PlaceRepositoryProtocol
    private let place: PlaceModel
    
    required init(
        repository: PlaceRepositoryProtocol,
        place: PlaceModel
    ) {
        self.repository = repository
        self.place = place
    }
    
    func getPlace() -> PlaceModel {
//        print(" Place Object : \(place)")
        return place
    }
    
    func updateFavoritePlace() -> AnyPublisher<PlaceEntity, Error> {
        return repository.updateFavoritePlace(by: place.id)
    }
}
