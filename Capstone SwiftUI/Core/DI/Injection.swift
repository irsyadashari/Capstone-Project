//
//  Injection.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 11/11/20.

import RealmSwift
import Foundation
import Core
import Place
import UIKit

final class Injection: NSObject {
    
    func providePlaceDatas<U: UseCase>() -> U where U.Request == Any, U.Response == [PlaceDomainModel] {
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let locale = GetPlacesLocaleDataSource(realm: appDelegate.realm)
        let remote = GetPlacesRemoteDataSource(endpoint: Endpoints.Gets.places.url)
        let mapper = PlaceTransformer()
        
        let repository = GetPlacesRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        
        return Interactor(repository: repository) as! U
    }
    
    private func provideRepository() -> PlaceRepositoryProtocol {
        let realm = try? Realm()
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return PlaceRepository.sharedInstance(locale, remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail(place: PlaceModel) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository, place: place)
    }
    
    func providePlace(place: PlaceModel) -> PlaceUseCase {
        let repository = provideRepository()
        return PlaceInteractor(repository: repository, place: place)
    }
    
    func provideFavorite() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }
    
//    func provideSearch() -> SearchUseCase {
//        let repository = provideRepository()
//        return SearchInteractor(repository: repository)
//    }
    
}
