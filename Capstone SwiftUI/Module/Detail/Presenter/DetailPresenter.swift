//
//  DetailPresenter.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 11/11/20.
//

import SwiftUI

class DetailPresenter: ObservableObject {
    
    private let detailUseCase: DetailUseCase
    
    @Published var place: PlaceModel
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        place = detailUseCase.getPlace()
    }
    
}
