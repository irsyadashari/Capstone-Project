//
//  FavoritePresenter.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 06/01/21.
//

import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let router = FavoriteRouter()
    private let favoriteUseCase: FavoriteUseCase
    
    @Published var places: [PlaceModel] = []
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    func getFavoritePlaces() {
        isLoading = true
        favoriteUseCase.getFavoritePlaces()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { places in
                self.places = places
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for meal: PlaceModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makePlaceView(for: meal)) { content() }
    }
    
}
