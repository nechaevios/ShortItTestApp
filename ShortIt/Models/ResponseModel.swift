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
    
    static let model = ResponseModel(longurl: "123", shorturl: "234")
}
