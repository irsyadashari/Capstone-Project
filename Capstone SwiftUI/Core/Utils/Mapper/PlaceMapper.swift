//
//  PlaceMapper.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 11/11/20.
//

final class PlaceMapper {
    
    static func mapPlaceResponsesToDomains(
        input placeResponses: [PlaceResponse]
    ) -> [PlaceModel] {
        
        return placeResponses.map { result in
            return PlaceModel(
                id: result.id,
                name: result.name,
                desc: result.desc,
                address: result.address,
                like: Int.random(in: 0..<101),
                image: result.image,
                isFavorite: false
                
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
            newPlace.desc = result.desc
            newPlace.address = result.address
            newPlace.like = Int.random(in: 0..<101)
            newPlace.image = result.image
            newPlace.isFavorite = false
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
                desc: result.desc,
                address: result.address,
                like: Int(result.like),
                image: result.image,
                isFavorite: result.isFavorite
            )
        }
    }
    
}
