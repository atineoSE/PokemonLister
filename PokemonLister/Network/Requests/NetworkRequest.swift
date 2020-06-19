//
//  NetworkRequest.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation

protocol ExtendedDataTask {
    func resume()
}

protocol NetworkSession {
    func extendedDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> ExtendedDataTask
}

extension URLSessionDataTask: ExtendedDataTask {}

extension URLSession: NetworkSession {
    func extendedDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> ExtendedDataTask {
        return dataTask(with: request, completionHandler: completionHandler) as ExtendedDataTask
    }
}

protocol NetworkRequest: class {
    associatedtype ModelType
    var urlRequest: URLRequest { get }
    var session: NetworkSession { get }
    var task: ExtendedDataTask? { get set }
    func deserialize(_ data: Data?, response: HTTPURLResponse) throws -> ModelType
}

extension NetworkRequest {
    func execute(withCompletion completion: @escaping (Result<ModelType, Error>) -> Void) {
        task = session.extendedDataTask(with: urlRequest) { [weak self] (data, response, error) in
            guard let strongSelf = self else {
                return
            }
            let result = Result { () throws -> ModelType in
                try error?.toNetworkError()
                guard let response = response as? HTTPURLResponse else {
                    throw NetworkError.unrecoverable
                }
                try response.validate()
                return try strongSelf.deserialize(data, response: response)
            }
            completion(result)
        }
        task?.resume()
        //print("Performing \(urlRequest.httpMethod ?? "<no verb>") request to url: \(urlRequest.url?.absoluteString ?? "<empty url>")")
        //print("Headers:")
        //print(urlRequest.allHTTPHeaderFields ?? "<no headers>")
    }
}

