//
//  File.swift
//  
//
//  Created by Irsyad Ashari on 05/01/21.
//

import Foundation

public enum URLError: LocalizedError {
    
    case invalidResponse
    case addressUnreachable(URL)
    
    public var errorDescription: String? {
        switch self {
        case .invalidResponse :
            return "server merespon dengan sampah"
        case .addressUnreachable (let url) :
            return "\(url.absoluteString) is unreachable to be"
        }
    }
}

public enum DatabaseError: LocalizedError {
    
    case invalidInstance
    case requestFailed
    
    public var errorDescription: String? {
        switch self {
            case .invalidInstance :
                return "instance database tidak ada."
            case .requestFailed :
                return "request gagal."
        }
    }
}
