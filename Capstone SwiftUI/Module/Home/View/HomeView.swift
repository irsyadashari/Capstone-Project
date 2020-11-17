//
//  HomeView.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 11/11/20.

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
    @State private var selection = 0
    
    @State private var isfavoritedExist = false
    
    var body: some View {
        
            TabView(selection: $selection) {
                ZStack{
                    if presenter.loadingState{
                        VStack{
                            Text("Memuat...")
                            ProgressView()
                        }
                    } else{
                        ScrollView(.vertical, showsIndicators: false){
                            ForEach(
                                self.presenter.places,
                                id: \.id
                            ){ place in
                                
                                ZStack{
                                    self.presenter.linkBuilder(for: place){
                                        PlaceRow(presenter: presenter, place: place)
                                    }.buttonStyle(PlainButtonStyle())
                                }.padding(8)
                            }
                        }
                    }
                }.onAppear{
                    if self.presenter.places.count == 0{
                        self.presenter.getPlaces()
                    }
                }.navigationBarTitle(
                    Text("Tourism App"),
                    displayMode: .automatic
                )
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
                
                
                ZStack{
                    if checkFavoriteTab(places: presenter.places) == false{
                        VStack{
                            
                            Image("No Favorite")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200, alignment: .center)
                                .clipShape(Circle())
                            Text("Anda belum menambahkan tempat favorit Anda!")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                    } else{
                        ScrollView(.vertical, showsIndicators: false){
                            ForEach(
                                self.presenter.places.filter{ $0.isFavorite == true}
                            ){ place in
                               
                                ZStack{
                                    self.presenter.linkBuilder(for: place){
                                        PlaceRow(presenter: presenter, place: place)
                                    }.buttonStyle(PlainButtonStyle())
                                }.padding(8)
                            }
                        }
                    }
                }.onAppear{
                    if self.presenter.places.count == 0{
                        self.presenter.getPlaces()
                    }
                }.navigationBarTitle(
                    Text("Tourism App"),
                    displayMode: .automatic
                )
                .tabItem {
                    Image(systemName: "bookmark.circle.fill")
                    Text("Favorite")
                }
                .tag(1)
                
                
                
                Text("Profile Tab")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
                    .tag(2)
                
                
                
            }
            .accentColor(.pink)
            .onAppear(){
                UITabBar.appearance().barTintColor = .white
            }
            
            .navigationTitle("Tourism App")

    }
    
    func checkFavoriteTab(places : [PlaceModel]) -> Bool{
        
        var isFavoritedExist = false
        
        for place in places{
            if place.isFavorite{
                isFavoritedExist = true
                return isFavoritedExist
            }
        }
        
        return isFavoritedExist
    }
}
