//
//  NetworkManager.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 16.01.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private enum Domains: String {
        case bitly = "bit.ly"
    }
    
    private enum ApiUrls: String {
        case shortenApiUrl = "https://api-ssl.bitly.com/v4/shorten"
    }
    
    private enum ApiKeys: String {
        case bitLyApiKey = "076df6aa095ff080918c787e69ee52a5b6854e94"
    }
        
    private init() {}
    
    func fetchShortUrl(longUrl: String, completion: @escaping (BitLyResponse?, Error?) -> Void) {
        fetchData(urlString: longUrl) { result in
            switch result {
                
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(BitLyResponse.self, from: data)
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
        
        struct PostData: Codable {
            let long_url: String
            var domain = Domains.bitly.rawValue
        }
        
        let postData = PostData(long_url: urlString)
        guard let jsonData = try? JSONEncoder().encode(postData) else { return }
        guard let url = URL(string: ApiUrls.shortenApiUrl.rawValue) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue(ApiKeys.bitLyApiKey.rawValue, forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, _, error in
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
