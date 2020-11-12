//
//  HomeView.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 11/11/20.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        
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
                                PlaceRow(place: place)
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
    }
}
