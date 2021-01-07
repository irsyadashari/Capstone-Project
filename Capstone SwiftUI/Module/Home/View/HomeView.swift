//
//  HomeView.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 11/11/20.

import SwiftUI
import Core
import Place

struct HomeView: View {
    
    @ObservedObject var presenter: GetListPresenter<Any, PlaceDomainModel,
                                                    Interactor<Any, [PlaceDomainModel],
                                                    GetPlacesRepository<GetPlacesLocaleDataSource,
                                                    GetPlacesRemoteDataSource, PlaceTransformer>>>
    
    private let homeRouter = HomeRouter()
    
    var body: some View {
        
        ZStack {
            if presenter.isLoading {
                loadingIndicator
            } else if presenter.isError {
                errorIndicator
            } else if presenter.list.isEmpty {
                emptyCategories
            } else {
                content
            }
        }.onAppear {
            if self.presenter.list.count == 0 {
                self.presenter.getList(request: nil)
            }
        }.navigationBarTitle(
            Text("Tourism Apps"),
            displayMode: .automatic
        )
        
    }
    
}

extension HomeView {
    
    func detailLinkBuilder<Content: View>(
        for place: PlaceModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: homeRouter.makeDetailView(for: place)) { content()} 
    }
    
    var loadingIndicator: some View {
        VStack {
            Text("Loading...")
            ActivityIndicator()
        }
    }
    
    var errorIndicator: some View {
        CustomEmptyView(
            image: "assetSearchNotFound",
            title: presenter.errorMessage
        ).offset(y: 80)
    }
    
    var emptyCategories: some View {
        CustomEmptyView(
            image: "assetNoFavorite",
            title: "List is empty"
        ).offset(y: 80)
    }
    
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(
                self.presenter.list,
                id: \.id
            ) { place in
                ZStack {
                    let placeModel = PlaceModel(id: place.id, name: place.name, desc: place.desc, address: place.address, like: place.like, image: place.image)
                    self.detailLinkBuilder(for: placeModel) {
                        PlaceRow(place: place)
                    }
                }.buttonStyle(PlainButtonStyle())
            }
        }
    }
}
struct MySearchBar: View {
    
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            HStack {
                TextField("Cari tempat favoritmu", text: $searchText)
                    .padding(.leading, 24)
            }
            .padding(6)
            .background(Color(.systemGray5))
            .cornerRadius(6)
            .padding(.horizontal)
            .onTapGesture( count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/) {
                isSearching = true
            }
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    if isSearching {
                        Button(action: {searchText = ""}, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        })
                    }
                    
                }.padding(.horizontal, 25)
                .foregroundColor(.gray)
            ).transition(.move(edge: .trailing))
            .animation(.spring())
            
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    UIApplication.shared.sendAction( #selector(UIResponder.resignFirstResponder),
                                                     to: nil, from: nil, for: nil)
                }, label: {
                    Text("Batal")
                        .padding(.trailing)
                        .padding(.leading, 0)
                })
                .transition(.move(edge: .trailing))
                .animation(.spring())
            }
        }
    }
    
}
