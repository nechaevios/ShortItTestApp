//
//  WebViewModel.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 21.01.2022.
//

import Foundation

protocol WebViewModelProtocol {
    var urlRequest: URLRequest? { get }
    init(response: Response)
}

class WebViewModel: WebViewModelProtocol {
    
    var urlRequest: URLRequest? {
        get {
            guard let myURL = URL(string: response.shorturl) else { return nil }
            return URLRequest(url: myURL)
        }
    }
    
    private var response: Response
    
    required init(response: Response) {
        self.response = response
    }
}
