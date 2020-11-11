//
//  CustomError+Ext.swift
//  Capstone Project
//
//  Created by Irsyad Ashari on 11/11/20.
//

import Foundation

enum URLError: LocalizedError{
    
    case invalidResponse
    case addressUnreachable(URL)
    
    var errorDescription: String?{
        switch self{
            case .invalidResponse: return "server merespon dengan sampah"
            case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable to be"
        }
    }
    
}

enum DatabaseError: LocalizedError{
    
    case invalidInstance
    case requestFailed
    
    var errorDescription: String?{
        switch self {
            case .invalidInstance: return "instance database tidak ada."
            case .requestFailed: return "request gagal."
        }
    }
}
