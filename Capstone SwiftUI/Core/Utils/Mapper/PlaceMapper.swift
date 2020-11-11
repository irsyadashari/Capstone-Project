//
//  PlaceMapper.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 11/11/20.
//

import Foundation

final class PlaceMapper {
    
    static func mapPlaceResponsesToDomains(
        input placeResponses: [PlaceResponse]
    ) -> [PlaceModel] {
        
        return placeResponses.map { result in
            return PlaceModel(
                id: result.id,
                name: result.name,
                description: result.description,
                address: result.address,
                like: Int(result.like),
                image: result.image
            )
        }
    }
    
    static func mapPlaceResponsesToEntities(
        input placeResponses: [PlaceResponse]
    ) -> [PlaceEntity] {
        return placeResponses.map { result in
            let newPlace = PlaceEntity()
            newPlace.id = Int(result.id)
            newPlace.name = result.name
            newPlace.desc = result.description
            newPlace.address = result.address
            newPlace.like = result.like
            newPlace.image = result.image
            return newPlace
        }
    }
    
    static func mapPlaceEntitiesToDomains(
        input placeEntities: [PlaceEntity]
    ) -> [PlaceModel] {
        return placeEntities.map { result in
            return PlaceModel(
                id: result.id,
                name: result.name,
                description: result.description,
                address: result.address,
                like: Int(result.like),
                image: result.image
            )
        }
    }
    
}
