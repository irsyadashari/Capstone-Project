//
//  File.swift
//  
//
//  Created by Irsyad Ashari on 05/01/21.
//

import Combine

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func list(request: Request?) -> AnyPublisher<[Response], Error>
    func add(entities: [Response]) -> AnyPublisher<Bool, Error>
    func update(id: Int, entity: Response) -> AnyPublisher<Bool, Error>
}
