//
//  HomeRouter.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 11/11/20.
//

import SwiftUI

class HomeRouter {
    
    func makeDetailView(for place: PlaceModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(place: place)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }
    
    func makePlaceView(for place: PlaceModel) -> some View {
        let placeUseCase = Injection.init().providePlace(place: place)
        let presenter = PlacePresenter(placeUseCase: placeUseCase)
        return PlaceView(presenter: presenter)
    }
}
