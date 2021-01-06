//
//  File.swift
//  
//
//  Created by Irsyad Ashari on 05/01/21.
//

import Combine
import Foundation

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func list(request: Request?) -> AnyPublisher<[Response], Error>
    func add(entities: [Response]) -> AnyPublisher<Bool, Error>
    func get(id: Int) -> AnyPublisher<Response, Error>
    func update(id: Int, entity: Response) -> AnyPublisher<Bool, Error>
}
