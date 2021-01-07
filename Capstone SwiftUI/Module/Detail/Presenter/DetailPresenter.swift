//
//  DetailPresenter.swift
//  Capstone SwiftUI
//
//  Created by Irsyad Ashari on 11/11/20.
//

import SwiftUI
import Combine

class DetailPresenter: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let detailUseCase: DetailUseCase
    
    @Published var place: PlaceModel
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        place = detailUseCase.getPlace()
    }
    
    func updateFavoritePlace() {
//        self.place.isFavorite.toggle()
        detailUseCase.updateFavoritePlace()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { place in
                let placeObj = PlaceModel(id: place.id, name: place.name, desc: place.desc, address: place.address, like: place.like, image: place.image)
                self.place = placeObj
            })
            .store(in: &cancellables)
    }
}
