//
//  PlaceRepository.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 11/11/20.
//

import Foundation

protocol PlaceRepositoryProtocol {
    
    func getPlaces(result: @escaping (Result<[PlaceModel], Error>) -> Void)
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
    
    func getPlaces(
        result: @escaping (Result<[PlaceModel], Error>) -> Void
    ) {
        locale.getPlaces { localeResponses in
            switch localeResponses {
                case .success(let placeEntity):
                    let placeList = PlaceMapper.mapPlaceEntitiesToDomains(input: placeEntity)
                    if placeList.isEmpty {
                        self.remote.getPlaces { remoteResponses in
                            switch remoteResponses {
                                case .success(let placeResponses):
                                    let placeEntities = PlaceMapper.mapPlaceResponsesToEntities(input: placeResponses)
                                    self.locale.addPlaces(from: placeEntities) { addState in
                                        switch addState {
                                            case .success(let resultFromAdd):
                                                if resultFromAdd {
                                                    self.locale.getPlaces { localeResponses in
                                                        switch localeResponses {
                                                            case .success(let placeEntity):
                                                                let resultList = PlaceMapper.mapPlaceEntitiesToDomains(input: placeEntity)
                                                                result(.success(resultList))
                                                            case .failure(let error):
                                                                result(.failure(error))
                                                        }
                                                    }
                                                }
                                            case .failure(let error):
                                                result(.failure(error))
                                        }
                                    }
                                case .failure(let error):
                                    result(.failure(error))
                            }
                        }
                    } else {
                        result(.success(placeList))
                    }
                case .failure(let error):
                    result(.failure(error))
            }
        }
    }
    
    
}
