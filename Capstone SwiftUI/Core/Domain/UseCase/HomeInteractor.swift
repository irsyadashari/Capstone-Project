//
//  HomeInteractor.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 11/11/20.
//

import Combine

protocol HomeUseCase {
    func getPlaces() -> AnyPublisher<[PlaceModel], Error>
    func toggleFavorite(place: PlaceModel) -> AnyPublisher<Bool, Error>
}

class HomeInteractor: HomeUseCase{
    
    private let repository: PlaceRepositoryProtocol
    
    required init (repository: PlaceRepositoryProtocol){
        self.repository = repository
    }
    
    func getPlaces() -> AnyPublisher<[PlaceModel], Error> {
        return repository.getPlaces()
    }
    
    func toggleFavorite(place: PlaceModel) -> AnyPublisher<Bool, Error> {
        return repository.toggleFavorite(place: place)
    }
    
}
