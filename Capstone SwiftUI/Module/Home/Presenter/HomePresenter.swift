//
//  HomePresenter.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 11/11/20.
//

import SwiftUI

class HomePresenter: ObservableObject {

    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    
    @Published var places: [PlaceModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getPlaces() {
        loadingState = true
        homeUseCase.getPlaces{ result in
            
            switch result {
                case .success(let places):
                    DispatchQueue.main.async {
                        self.loadingState = false
                        self.places = places
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.loadingState = false
                        self.errorMessage = error.localizedDescription
                    }
            }
            
        }
    }
    
    func linkBuilder<Content: View>(
        for place: PlaceModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: place)) { content() }
    }
    
}
