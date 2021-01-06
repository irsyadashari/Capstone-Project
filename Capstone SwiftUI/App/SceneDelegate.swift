//
//  SceneDelegate.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 11/11/20.
//

import UIKit
import SwiftUI
import RealmSwift
import Core
import Place

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions
    ) {
        let favoriteUseCase = Injection.init().provideFavorite()
        let placeUseCase: Interactor<
            Any,
            [PlaceDomainModel],
            GetPlacesRepository<
                GetPlacesLocaleDataSource,
                GetPlacesRemoteDataSource,
                PlaceTransformer>
        > = Injection.init().providePlaceDatas()
        
        let homePresenter = GetListPresenter(useCase: placeUseCase)
        let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)
        
        let contentView = ContentView()
            .environmentObject(homePresenter)
            .environmentObject(favoritePresenter)
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
