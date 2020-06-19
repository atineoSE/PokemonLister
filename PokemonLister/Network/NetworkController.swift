//
//  NetworkController.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation
import UIKit

class NetworkController: NSObject {
    private let session: URLSession
    private var requests: [URL: AnyObject] = [:]

    init(session: URLSession) {
        self.session = session
        requests = [:]
    }
    
    deinit {
        session.finishTasksAndInvalidate()
    }
    
    func get<ModelType>(url: URL, completion: @escaping (Result<ModelType, Error>) -> Void) where ModelType:Decodable {
        let getRequest = GetEntityRequest<ModelType>(url: url, session: session)
        requests[url] = getRequest
        getRequest.execute { [weak self] result in
            completion(result)
            self?.requests[url] = nil
        }
    }

}
