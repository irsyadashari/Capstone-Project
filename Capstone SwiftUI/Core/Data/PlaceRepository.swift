//
//  PlaceRepository.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 11/11/20.
//

import Combine
import Foundation

protocol PlaceRepositoryProtocol {
    
    func getPlaces() -> AnyPublisher<[PlaceModel], Error>
    func getPlace(by idPlace: Int) -> AnyPublisher<PlaceModel, Error>
//    func searchPlace(by name: String) -> AnyPublisher<[PlaceModel], Error>
    func getFavoritePlaces() -> AnyPublisher<[PlaceModel], Error>
    func updateFavoritePlace(by idPlace: Int) -> AnyPublisher<PlaceEntity, Error>
}

final class PlaceRepository: NSObject {
    
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

extension PlaceRepository: PlaceRepositoryProtocol {
    
    func getPlaces() -> AnyPublisher<[PlaceModel], Error> {
        return self.locale.getPlaces()
            .flatMap { result -> AnyPublisher<[PlaceModel], Error> in
                
                if result.isEmpty {
                    print("ini result kosong")
                    return self.remote.getPlaces()
                        .map { PlaceMapper.mapPlaceResponsesToEntities(input: $0) }
                        .catch { _ in self.locale.getPlaces() }
                        .flatMap { self.locale.addPlaces(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getPlaces()
                            .map { PlaceMapper.mapPlaceEntitiesToDomains(input: $0) }
                        }
                        .eraseToAnyPublisher()
                } else {
                    print("ini result local")
                    return self.locale.getPlaces()
                        .map { PlaceMapper.mapPlaceEntitiesToDomains(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getPlace(
        by idPlace: Int
    ) -> AnyPublisher<PlaceModel, Error> {
        return self.locale.getPlace(by: idPlace)
            .flatMap { _ -> AnyPublisher<PlaceModel, Error> in
                
                return self.locale.getPlace(by: idPlace)
                    .map { PlaceMapper.mapDetailPlaceEntityToDomain(input: $0) }
                    .eraseToAnyPublisher()
                
            }.eraseToAnyPublisher()
    }
    
//    func searchPlace(by name: String) -> AnyPublisher<[PlaceModel], Error> {
//        return self.locale.getPlace(by: )
//    }
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceModel], Error> {
        return self.locale.getFavoritePlaces()
            .map { PlaceMapper.mapPlaceEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func updateFavoritePlace(
        by idPlace: Int
    ) -> AnyPublisher<PlaceEntity, Error> {
        return self.locale.updateFavoritePlace(by: idPlace)
    }
    
}
