//
//  File.swift
//  
//
//  Created by Irsyad Ashari on 05/01/21.
//

import Foundation

public struct PlaceDomainModel: Equatable, Identifiable {
    
    public let id: Int
    public let name: String
    public let desc: String
    public let address: String
    public let like: Int
    public let image: String
    public var isFavorite: Bool
    
    public init(id: Int, name: String, desc: String, address: String, like: Int, image: String, isFavorite: Bool) {
      
        self.id = Int(id)
        self.name = name
        self.desc = desc
        self.address = address
        self.like = Int.random(in: 0..<101)
        self.image = image
        self.isFavorite = isFavorite
    }
}
