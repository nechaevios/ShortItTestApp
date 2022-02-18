//
//  WebViewModel.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 21.01.2022.
//

import Foundation

protocol WebViewModelProtocol {
    var urlRequest: URLRequest? { get }
    init(response: BitLyResponse)
}

class WebViewModel: WebViewModelProtocol {
    
    var urlRequest: URLRequest? {
        get {
            guard let myURL = URL(string: response.link) else { return nil }
            return URLRequest(url: myURL)
        }
    }
    
    private var response: BitLyResponse
    
    required init(response: BitLyResponse) {
        self.response = response
    }
}
