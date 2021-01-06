//
//  FavoriteRouter.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 13/11/20.
//

import SwiftUI

class FavoriteRouter {
    
  func makePlaceView(for place: PlaceModel) -> some View {
        let placeUseCase = Injection.init().providePlace(place: place)
        let presenter = PlacePresenter(placeUseCase: placeUseCase)
        return PlaceView(presenter: presenter)
    }
    
}
