//
//  File.swift
//  
//
//  Created by Irsyad Ashari on 05/01/21.
//

import Combine

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func getPlaces(request: Request?) -> AnyPublisher<[Response], Error>
    func addPlaces(entities: [Response]) -> AnyPublisher<Bool, Error>
    func toggleFavorite(place: PlaceModel) -> AnyPublisher<PlaceModel, Error>
}
