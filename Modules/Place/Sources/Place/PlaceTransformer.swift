//
//  File.swift
//  
//
//  Created by Irsyad Ashari on 05/01/21.
//

import Core

public struct PlaceTransformer: Mapper {
    
    public typealias Response = [PlaceResponse]
    public typealias Entity = [PlaceModuleEntity]
    public typealias Domain = [PlaceDomainModel]
    
    public init() {}
    
    public func transformResponseToEntity(response: [PlaceResponse]) -> [PlaceModuleEntity] {
        return response.map { result in
            let newPlace = PlaceModuleEntity()
            newPlace.id = Int(result.id)
            newPlace.name = result.name
            newPlace.desc = result.desc
            newPlace.address = result.address
            newPlace.like = Int.random(in: 0..<101)
            newPlace.image = result.image
            newPlace.isFavorite = false
            return newPlace
        }
    }
    
    public func transformEntityToDomain(entity: [PlaceModuleEntity]) -> [PlaceDomainModel] {
        return entity.map { result in
            return PlaceDomainModel(
                id: result.id,
                name: result.name,
                desc: result.desc,
                address: result.address,
                like: Int(result.like),
                image: result.image,
                isFavorite: result.isFavorite
            )
        }
    }
}
