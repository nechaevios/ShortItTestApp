//
//  ResponseModel.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 16.01.2022.
//

import Foundation

struct ResponseModel: Decodable {
    let longurl: String
    let shorturl: String
    
    static func getResponses() -> [ResponseModel] {
        var responses: [ResponseModel] = []
        
        for responseIndex in 0..<10 {
            let response = ResponseModel(longurl: "https://longurl\(responseIndex).com", shorturl: "http://shorturl\(responseIndex).com")
            
            responses.append(response)
        }
        
        return responses
    }
}
