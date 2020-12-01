//
//  DetailInteractor.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 11/11/20.

protocol DetailUseCase {
    
    func getPlace() -> PlaceModel
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
        return place
    }
    
}
