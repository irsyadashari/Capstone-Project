//
//  APICall.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 09/11/20.
//

import Foundation

struct API {
    
    static let baseUrl = "https://tourism-api.dicoding.dev"
    
}

protocol Endpoint {
    
    var url: String { get }
    
}

enum Endpoints {
    
    enum Gets: Endpoint {
        
        case places

        public var url: String {
            switch self {
                
                case .places: return "\(API.baseUrl)/list"
               
            }
        }
    }
    
}
