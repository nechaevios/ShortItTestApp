//
//  String + Extension.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 18.01.2022.
//

import Foundation

extension String {
    enum ValidationType {
        case url
    }
    
    enum Regex: String {
        case url = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
    }
    
    func isValid(_ validationType: ValidationType) -> Bool {
        let format = "SELF MATCHES %@"
        var regEx = ""
        
        switch validationType {
        case .url:
            regEx = Regex.url.rawValue
        }
        
        return NSPredicate(format: format, regEx).evaluate(with: self)
    }
}
