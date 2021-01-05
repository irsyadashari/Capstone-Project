//
//  File.swift
//  
//
//  Created by Irsyad Ashari on 05/01/21.
//

import Foundation

public struct PlacesResponse: Decodable {
    let message: String
    let places: [PlaceResponse]
}

public struct PlaceResponse: Decodable {
    
    let id: Int
    let name: String
    let desc: String
    let address: String
    let like: Int
    let image: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc = "description"
        case address
        case like
        case image
    }
    
}
