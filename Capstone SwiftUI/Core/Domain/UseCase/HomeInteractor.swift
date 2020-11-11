//
//  HomeInteractor.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 11/11/20.
//

import Foundation

protocol HomeUseCase {
    
    func getPlaces(completion: @escaping (Result<[PlaceModel], Error>) -> Void)
    
}

class HomeInteractor: HomeUseCase{
    
    private let repository: PlaceRepositoryProtocol
    
    required init (repository: PlaceRepositoryProtocol){
        self.repository = repository
    }
    
    func getPlaces(completion: @escaping (Result<[PlaceModel], Error>) -> Void) {
        repository.getPlaces { result in
            completion(result)
        }
    }
    
}
