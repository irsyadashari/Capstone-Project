//
//  ContentView.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 11/11/20.
//

import SwiftUI
import Core
import Place

struct ContentView: View {
    @EnvironmentObject var homePresenter: GetListPresenter<Any,
                                          PlaceDomainModel,
                                          Interactor<Any, [PlaceDomainModel],
                                          GetPlacesRepository<GetPlacesLocaleDataSource,
                                          GetPlacesRemoteDataSource,
                                          PlaceTransformer>>>
    
    @EnvironmentObject var favoritePresenter: FavoritePresenter
    
    var body: some View {
       
        TabView {
            NavigationView {
                HomeView(presenter: homePresenter)
            }.tabItem {
                TabItem(imageName: "house", title: "Home")
            }
            
            NavigationView {
                FavoriteView(presenter: favoritePresenter)
            }.tabItem {
                TabItem(imageName: "heart", title: "Favorite")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
