//
//  RemoteDataSource.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 11/11/20.
//

import Foundation
import Alamofire

protocol RemoteDataSourceProtocol: class{
    
    func getPlaces(result: @escaping (Result<[PlaceResponse], URLError>) -> Void)
    
}

final class RemoteDataSource: NSObject{
    
    private override init(){}
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol{
    
    func getPlaces(result: @escaping (Result<[PlaceResponse], URLError>) -> Void) {
        
        guard let url = URL(string: Endpoints.Gets.places.url) else{ return }
        
        AF.request(url).validate().responseDecodable(of: PlacesResponse.self){response in
            
            switch response.result{
                
                case .success(let value):
                    result(.success(value.places))
                
                case .failure:
                    result(.failure(.invalidResponse))
            }
            
        }
        
    }
    
}
