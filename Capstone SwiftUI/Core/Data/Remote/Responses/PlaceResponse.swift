//
//  PlaceResponse.swift
//  VacationSite
//
//  Created by Irsyad Ashari on 05/11/20.
//

struct PlacesResponse: Decodable {
    let message: String
    let places: [PlaceResponse]
}

struct PlaceResponse: Decodable {
    let id: Int
    let name: String
    let desc: String
    let address: String
    let like: Int
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc = "description"
        case address
        case like
        case image
    }
    
}
