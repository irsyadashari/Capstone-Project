//
//  HomeInteractor.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 11/11/20.
//

import Foundation
import Combine

protocol HomeUseCase {
    func getPlaces() -> AnyPublisher<[PlaceModel], Error>
}

class HomeInteractor: HomeUseCase{
    
    private let repository: PlaceRepositoryProtocol
    
    required init (repository: PlaceRepositoryProtocol){
        self.repository = repository
    }
    
    func getPlaces() -> AnyPublisher<[PlaceModel], Error> {
        return repository.getPlaces()
    }
    
}
