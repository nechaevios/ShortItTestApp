//
//  Response.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 16.01.2022.
//

import Foundation

struct Response: Decodable, Encodable {
    let longurl: String
    let shorturl: String
}
