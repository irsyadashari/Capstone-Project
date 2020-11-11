//
//  PlaceResponse.swift
//  VacationSite
//
//  Created by Irsyad Ashari on 05/11/20.
//

import Foundation

struct PlacesResponse: Decodable {
    let message: String
    let places: [PlaceResponse]
}

struct PlaceResponse: Decodable {
    let id: Int
    let name: String
    let description: String
    let address: String
    let like: Int
    let image: String
}
