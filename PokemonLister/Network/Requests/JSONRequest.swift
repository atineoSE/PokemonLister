//
//  JSONRequest.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation

protocol JSONDataRequest: NetworkRequest where ModelType: Decodable {}

extension JSONDataRequest {
    func deserialize(_ data: Data?, response: HTTPURLResponse) throws -> ModelType {
        guard let data = data else {
            throw NetworkError.unrecoverable
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        let model = try decoder.decode(ModelType.self, from: data)
        return model
    }
}


