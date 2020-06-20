//
//  PersistenceController.swift
//  PokemonLister
//
//  Created by Adrian Tineo on 19.06.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation

class PersistenceController {
    private let networkController: NetworkController
    private let cachesDirectoryURL = FileManager.default
        .urls(for: .cachesDirectory, in: .userDomainMask)
        .first!
    private var filesIndex: URL {
        return cachesDirectoryURL
            .appendingPathComponent("FilesIndex")
            .appendingPathExtension("plist")
    }
    private lazy var decoder = PropertyListDecoder()
    private lazy var encoder = PropertyListEncoder()
    private var filesIndexDictionary: [URL:URL] {
        guard let plistData = try? Data(contentsOf: filesIndex) else { return [:] }
        guard let dict = try? decoder.decode([URL:URL].self, from: plistData) else { return [:] }
        return dict
    }
    private var newLocalFile: URL {
        return cachesDirectoryURL
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("plist")
    }
    
    init(networkController: NetworkController) {
        self.networkController = networkController
    }
    
    func fetch<T>(url: URL, completion: @escaping (T?)->()) where T: Codable {
        if let localUrl = filesIndexDictionary[url],
            let value: T = fetch(localURL: localUrl) {
            completion(value)
        } else {
            networkController.get(url: url) { [weak self] (result: Result<T,Error>) in
                if let value = try? result.get() {
                    self?.save(value, for: url)
                    completion(value)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    // MARK: Private
    private func fetch<T>(localURL: URL) -> T? where T: Decodable {
        guard let plistData = try? Data(contentsOf: localURL) else {
            return nil
        }
        return try? decoder.decode(T.self, from: plistData)
    }
    
    private func save<T>(_ value: T, for url: URL) where T: Encodable {
        if let plistData = try? encoder.encode(value) {
            let localURL = newLocalFile
            saveIndex(url: url, localURL: localURL)
            try? plistData.write(to: localURL)
        }
    }
    
    private func saveIndex(url:URL, localURL: URL) {
        var existingFilesIndex = filesIndexDictionary
        existingFilesIndex[url] = localURL
        if let plistData = try? encoder.encode(existingFilesIndex) {
            try? plistData.write(to: filesIndex)
        }
    }
    
}
