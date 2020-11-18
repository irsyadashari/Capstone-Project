//
//  FavoriteRouter.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 13/11/20.
//

import SwiftUI

class FavoriteRouter{
    
    func makeDetailView(for place: PlaceModel) -> some View{
        let detailUseCase = Injection.init().provideDetail(place: place)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }
    
}
