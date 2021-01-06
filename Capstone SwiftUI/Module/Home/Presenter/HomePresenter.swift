//
//  HomePresenter.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 11/11/20.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    
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
        homeUseCase.getPlaces()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { places in
                self.places = places
                print("places : \(places)")
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for place: PlaceModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
          destination: router.makeDetailView(for: place, homePresenter: self)) { content() }
    }
    
}
