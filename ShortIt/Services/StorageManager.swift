//
//  StorageManager.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 17.01.2022.
//

import Foundation

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private let archiveURL: URL
    
    private init () {
        archiveURL = documentDirectory.appendingPathComponent("UrlList").appendingPathExtension("plist")
    }
    
    func saveResponse(response: Response) {
        var responses = fetchUrlList()
        responses.append(response)
        guard let data = try? PropertyListEncoder().encode(responses) else { return }
        try? data.write(to: archiveURL, options: .noFileProtection)
    }
    
    func deleteResponse(at index: Int) {
        var responses = fetchUrlList()
        responses.remove(at: index)
        guard let data = try? PropertyListEncoder().encode(responses) else { return }
        try? data.write(to: archiveURL, options: .noFileProtection)
    }
    
    func fetchUrlList() -> [Response] {
        guard let data = try? Data(contentsOf: archiveURL) else { return [] }
        guard let responses = try? PropertyListDecoder().decode([Response].self, from: data) else { return [] }
        return responses
    }
    
}
