//
//  NetworkError.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case unauthorized
    case unrecoverable
    case temporary
    case unreachable
}

extension HTTPURLResponse {
    func validate() throws {
        switch statusCode {
        case 401:
            print("HTTP CLIENT ERROR: statusCode 401 (unauthorized) - throwing NetworkError.unauthorized")
            print(self)
            throw NetworkError.unauthorized
        case 404:
            print("HTTP CLIENT ERROR: statusCode 404 (not found) - throwing NetworkError.unrecoverable")
            print(self)
            throw NetworkError.unrecoverable
        case 400, 402, 403, 405 ..< 500:
            print("HTTP CLIENT ERROR: statusCode \(statusCode) - throwing NetworkError.unrecoverable")
            print(self)
            throw NetworkError.unrecoverable
        case 500 ..< 600:
            print("HTTP SERVER ERROR: statusCode \(statusCode) - throwing NetworkError.temporary")
            print(self)
            throw NetworkError.temporary
        default: break
        }
    }
}

extension Error {
    func toNetworkError() throws {
        switch self {
        case URLError.cannotConnectToHost,
             URLError.networkConnectionLost,
             URLError.notConnectedToInternet,
             URLError.timedOut:
            throw NetworkError.unreachable
        default:
            throw NetworkError.unrecoverable
        }
    }
}

