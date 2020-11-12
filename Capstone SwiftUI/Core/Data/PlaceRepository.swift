//
//  PlaceRepository.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 11/11/20.
//

import Foundation
import Combine

protocol PlaceRepositoryProtocol {
    
    func getPlaces() -> AnyPublisher<[PlaceModel], Error>
}

final class PlaceRepository: NSObject{
    
    typealias PlaceInstance = (LocaleDataSource, RemoteDataSource) -> PlaceRepository
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.remote = remote
        self.locale = locale
    }
    static let sharedInstance: PlaceInstance = { localeRepo, remoteRepo in
        return PlaceRepository(locale: localeRepo, remote: remoteRepo)
    }
    
}

extension PlaceRepository: PlaceRepositoryProtocol{
    
    func getPlaces() -> AnyPublisher<[PlaceModel], Error>{
        
        return self.locale.getPlaces()
            .flatMap{ result -> AnyPublisher<[PlaceModel], Error> in
                if result.isEmpty {
                    
                    return self.remote.getPlaces()
                        .map { PlaceMapper.mapPlaceResponsesToEntities(input: $0) }
                        .flatMap { self.locale.addPlaces(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getPlaces()
                            .map { PlaceMapper.mapPlaceEntitiesToDomains(input: $0) }
                        }
                        .eraseToAnyPublisher()
                    
                }else{
                    return self.locale.getPlaces()
                        .map { PlaceMapper.mapPlaceEntitiesToDomains(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
        
    }
    
    
}
