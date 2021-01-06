//
//  PlacePresenter.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 06/01/21.
//

import Foundation
import Combine

class PlacePresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let placeUseCase: PlaceUseCase
    
    @Published var place: PlaceModel
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    init(placeUseCase: PlaceUseCase) {
        self.placeUseCase = placeUseCase
        place = placeUseCase.getPlace()
    }
    
    func getPlace() {
        isLoading = true
        placeUseCase.getPlace()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { place in
                self.place = place
            })
            .store(in: &cancellables)
    }
    
    func updateFavoritePlace() {
        placeUseCase.updateFavoritePlace()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { place in
                self.place = place
            })
            .store(in: &cancellables)
    }
    
}
