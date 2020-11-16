//
//  PlaceModel.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 11/11/20.
//

import Foundation

struct PlaceModel: Equatable, Identifiable {
    
    let id: Int
    let name: String
    let desc: String
    let address: String
    let like: Int
    let image: String
    let isFavorite: Bool
}
