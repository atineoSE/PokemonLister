//
//  NetworkRequestsTests.swift
//  PokemonListerTests
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation
import XCTest
@testable import PokemonLister

class NetworkRequestTests: XCTestCase {
    
    // MARK: Tests
    func testNetworkRequestExecution() {
        // Arrange
        let stubbedJsonAsInput = ["sampleKey": "input"];
        let stubbedInputData = try! JSONSerialization.data(withJSONObject: stubbedJsonAsInput, options: [])
        let stubbedResponse = HTTPURLResponse(url: URL(string: "test.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let session = NetworkSessionStub(stubbedData: stubbedInputData, stubbedResponse: stubbedResponse, stubbedError: nil)
        let stubbedUrlRequest = URLRequest(url: URL(string: "test.com")!)
        let request = NetworkRequestSpy(stubbedSession: session, stubbedUrlRequest: stubbedUrlRequest)
        
        // Act
        request.execute { _ in
            // Assert
            XCTAssertEqual(request.receivedData, stubbedInputData)
            XCTAssertEqual(session.receivedUrlRequest, stubbedUrlRequest)
            XCTAssertEqual(request.receivedResponse, stubbedResponse)
        }
    }
    
    func testNetworkRequestThrowsUnreachableNetworkErrorIfCannotConnectToHost() {
        // Arrange
        let stubbedError = URLError(.cannotConnectToHost)
        let session = NetworkSessionStub(stubbedData: nil, stubbedResponse: nil, stubbedError: stubbedError)
        let stubbedUrlRequest = URLRequest(url: URL(string: "unreachableDomain.com")!)
        let request = NetworkRequestSpy(stubbedSession: session, stubbedUrlRequest: stubbedUrlRequest)
        
        // Act
        request.execute { result in
            // Assert
            do {
                let _ = try result.get()
                XCTFail("Did not throw error")
            } catch NetworkError.unreachable {
            } catch {
                XCTFail("Unexpected error")
            }
        }
    }

    func testJSONDataRequestReturnsDecodedModelWhenDataIsValid() {
        // Arrange
        let stubbedJsonAsInput = ["sampleKey": "input"];
        let stubbedInputData = try! JSONSerialization.data(withJSONObject: stubbedJsonAsInput, options: [])
        let stubbedResponse = HTTPURLResponse(url: URL(string: "test.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let session = NetworkSessionStub(stubbedData: stubbedInputData, stubbedResponse: stubbedResponse, stubbedError: nil)
        let stubbedUrlRequest = URLRequest(url: URL(string: "test.com")!)
        let request = JSONDataRequestStub(stubbedSession: session, stubbedUrlRequest: stubbedUrlRequest)
        let expectedModel = DummyModel(sampleKey: "input")

        // Act
        request.execute { result in
            // Assert
            XCTAssertEqual(try! result.get(), expectedModel)
        }
    }
    
    func testJSONDataRequestThrowsDecodingErrorWhenDataIsInvalid() {
        // Arrange
        let stubbedJsonAsInput = ["nonRecognizedKey": "input"];
        let stubbedInputData = try! JSONSerialization.data(withJSONObject: stubbedJsonAsInput, options: [])
        let stubbedResponse = HTTPURLResponse(url: URL(string: "test.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let session = NetworkSessionStub(stubbedData: stubbedInputData, stubbedResponse: stubbedResponse, stubbedError: nil)
        let stubbedUrlRequest = URLRequest(url: URL(string: "test.com")!)
        let request = JSONDataRequestStub(stubbedSession: session, stubbedUrlRequest: stubbedUrlRequest)
        
        // Act
        request.execute { result in
            // Assert
            do {
                let _ = try result.get()
                XCTFail("Did not throw error")
            } catch Swift.DecodingError.keyNotFound(_, _) {
            } catch {
                XCTFail("Unexpected error")
            }
        }
    }
    
    func testJSONDataRequestThrowsUnrecoverableNetworkErrorWhenHTTPStatusCodeIs404() {
        // Arrange
        let stubbedResponse = HTTPURLResponse(url: URL(string: "test.com")!, statusCode: 404, httpVersion: "HTTP/1.1", headerFields: nil)!
        let session = NetworkSessionStub(stubbedData: Data(), stubbedResponse: stubbedResponse, stubbedError: nil)
        let stubbedUrlRequest = URLRequest(url: URL(string: "test.com")!)
        let request = JSONDataRequestStub(stubbedSession: session, stubbedUrlRequest: stubbedUrlRequest)
        
        // Act
        request.execute { result in
            // Assert
            // Assert
            do {
                let _ = try result.get()
                XCTFail("Did not throw error")
            } catch NetworkError.unrecoverable {
            } catch {
                XCTFail("Unexpected error")
            }
        }
    }
    
    func testJSONDataRequestThrowsTemporaryNetworkErrorWhenHTTPStatusCodeIs500() {
        // Arrange
        let stubbedResponse = HTTPURLResponse(url: URL(string: "test.com")!, statusCode: 500, httpVersion: "HTTP/1.1", headerFields: nil)!
        let session = NetworkSessionStub(stubbedData: Data(), stubbedResponse: stubbedResponse, stubbedError: nil)
        let stubbedUrlRequest = URLRequest(url: URL(string: "test.com")!)
        let request = JSONDataRequestStub(stubbedSession: session, stubbedUrlRequest: stubbedUrlRequest)
        
        // Act
        request.execute { result in
            // Assert
            do {
                let _ = try result.get()
                XCTFail("Did not throw error")
            } catch NetworkError.temporary {
            } catch {
                XCTFail("Unexpected error")
            }
        }
    }

    func testJSONDataRequestThrowsUnrecoverableNetworkErrorForNonHTTPResponse() {
        // Arrange
        let stubbedResponse = URLResponse(url: URL(string: "test.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let session = NetworkSessionStub(stubbedData: Data(), stubbedResponse: stubbedResponse, stubbedError: nil)
        let stubbedUrlRequest = URLRequest(url: URL(string: "test.com")!)
        let request = JSONDataRequestStub(stubbedSession: session, stubbedUrlRequest: stubbedUrlRequest)
        
        // Act
        request.execute { result in
            // Assert
            do {
                let _ = try result.get()
                XCTFail("Did not throw error")
            } catch NetworkError.unrecoverable {
            } catch {
                XCTFail("Unexpected error")
            }
        }
    }
}

// MARK: Test doubles
struct DummyModel: Codable, Equatable {
    let sampleKey: String
}

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

class DataTaskStub: ExtendedDataTask {
    let stubbedData: Data?
    let stubbedResponse: URLResponse?
    let stubbedError: Error?
    let completion: DataTaskResult
    
    var receivedUrlRequest: URLRequest? = nil
    
    init(stubbedData: Data?, stubbedResponse: URLResponse?, stubbedError: Error?, completion: @escaping DataTaskResult) {
        self.stubbedData = stubbedData
        self.stubbedResponse = stubbedResponse
        self.stubbedError = stubbedError
        self.completion = completion
    }
    
    func resume() {
        completion(stubbedData, stubbedResponse, stubbedError)
    }
}

class NetworkSessionStub: NetworkSession {
    let stubbedData: Data?
    let stubbedResponse: URLResponse?
    let stubbedError: Error?
    
    var receivedUrlRequest: URLRequest?
    
    init(stubbedData: Data?, stubbedResponse: URLResponse?, stubbedError: Error?) {
        self.stubbedData = stubbedData
        self.stubbedResponse = stubbedResponse
        self.stubbedError = stubbedError
    }
    
    func extendedDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> ExtendedDataTask {
        receivedUrlRequest = request
        return DataTaskStub(stubbedData: stubbedData,
                            stubbedResponse: stubbedResponse,
                            stubbedError: stubbedError,
                            completion: completionHandler)
    }
}

class NetworkRequestSpy: NetworkRequest {
    typealias ModelType = DummyModel
    let session: NetworkSession
    var task: ExtendedDataTask?
    
    var urlRequest: URLRequest {
        return stubbedUrlRequest
    }
    
    let stubbedUrlRequest: URLRequest
    var receivedData: Data? = nil
    var receivedResponse: URLResponse? = nil
    
    init(stubbedSession: NetworkSession, stubbedUrlRequest: URLRequest) {
        self.session = stubbedSession
        self.stubbedUrlRequest = stubbedUrlRequest
    }
    
    func deserialize(_ data: Data?, response: HTTPURLResponse) throws -> DummyModel {
        receivedData = data
        receivedResponse = response
        return DummyModel(sampleKey: "")
    }
}

class JSONDataRequestStub: JSONDataRequest {
    typealias ModelType = DummyModel
    let session: NetworkSession
    var task: ExtendedDataTask?
    let stubbedUrlRequest: URLRequest
    
    var urlRequest: URLRequest {
        return stubbedUrlRequest
    }
    
    init(stubbedSession: NetworkSession, stubbedUrlRequest: URLRequest) {
        self.session = stubbedSession
        self.stubbedUrlRequest = stubbedUrlRequest
    }
}
