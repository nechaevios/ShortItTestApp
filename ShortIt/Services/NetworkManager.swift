//
//  NetworkManager.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 16.01.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let apiUrl = "http://tiny-url.info/api/v1/random?format=json&url="
    
    private init() {}
    
    func fetchShortUrl(longUrl: String, completion: @escaping (ResponseModel?, Error?) -> Void) {
        fetchData(urlString: longUrl) { result in
            switch result {
                
            case .success(let data):
                do {
                let response = try JSONDecoder().decode(ResponseModel.self, from: data)
                completion(response, nil)
                } catch let jsonError {
                    print(jsonError)
                }
            case .failure(let error):
                print("Error received: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
    }
    
    private func fetchData(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: apiUrl+urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }
}
