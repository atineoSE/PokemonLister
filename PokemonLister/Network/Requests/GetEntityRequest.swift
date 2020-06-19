//
//  GetEntityRequest.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation

class GetEntityRequest<ModelType: Decodable>: NetworkRequest, JSONDataRequest {
    let url: URL
    let session: NetworkSession
    var task: ExtendedDataTask?

    init(url: URL, session: NetworkSession) {
        self.url = url
        self.session = session
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}


