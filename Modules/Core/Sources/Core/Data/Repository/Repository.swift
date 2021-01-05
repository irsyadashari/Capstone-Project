//
//  File.swift
//  
//
//  Created by Irsyad Ashari on 05/01/21.
//

import Foundation
import Combine

public protocol Repository {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
