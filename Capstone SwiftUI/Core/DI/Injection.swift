//
//  Injection.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 11/11/20.
//

import Foundation
import RealmSwift

final class Injection: NSObject{
    
    private func provideRepository() -> PlaceRepositoryProtocol{
        
        let realm = try? Realm()
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return PlaceRepository.sharedInstance(locale, remote)
    }
    
    func provideHome() -> HomeUseCase{
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail(place: PlaceModel) -> DetailUseCase{
        let repository = provideRepository()
        return DetailInteractor(repository: repository, place: place)
    }
    
}
