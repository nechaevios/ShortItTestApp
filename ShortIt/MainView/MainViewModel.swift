//
//  MainViewModel.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 19.01.2022.
//

import Foundation

protocol MainViewModelProtocol {
    var viewModelDidChange: ((MainViewModelProtocol) -> ())? { get set }
    var textLabelData: String { get }
    var textFieldPlaceholder: String { get }
    var navigationItemText: String { get }
    var resultLabelText: String { get }
    var resultLabelState: Bool { get }
    var buttonTitle: String { get }
    func fetchShortUrl(urlString: String?)
}

final class MainViewModel: MainViewModelProtocol {
    
    var resultLabelText: String {
        get {
            resultText
        }
    }
    
    var resultLabelState: Bool {
        get {
            userInteractionStatus
        }
    }
    
    var navigationItemText: String {
        "Short It!"
    }
    
    var textFieldPlaceholder: String {
        "https://example.com"
    }
    
    var textLabelData: String {
        "Enter URL:"
    }
    
    var buttonTitle: String {
        "Short It!"
    }
    
    var viewModelDidChange: ((MainViewModelProtocol) -> ())?
    
    private let textFieldValidationType: String.ValidationType = .url
    
    private var resultText: String = " "
    
    private var userInteractionStatus = false
    
    func fetchShortUrl(urlString: String?) {
        
        guard let urlString = urlString else { return }
        
        if urlString.isEmpty {
            setResultTextAndUserInteractionMode(as: "Empty URL")
            return
        }
        
        if checkValid(urlString) {
            setResultTextAndUserInteractionMode(as: "...")
            
            NetworkManager.shared.fetchShortUrl(longUrl: urlString) { [ weak self ] responseModel, error in
                if error == nil {
                    guard let responseModel = responseModel else { return }
                    StorageManager.shared.saveResponse(response: responseModel)
                    self?.setResultTextAndUserInteractionMode(as: responseModel.shorturl, and: true)
                } else {
                    self?.setResultTextAndUserInteractionMode()
                }
            }
        }
    }
    
    private func checkValid(_ string: String) ->  Bool {
        switch textFieldValidationType {
        case .url:
            if string.isValid(textFieldValidationType) {
                return true
            } else {
                setResultTextAndUserInteractionMode(as: "Url is not valid! Format: http(s)://url.com")
                return false
            }
        }
    }
    
    private func setResultTextAndUserInteractionMode(as text: String = " ", and status: Bool = false) {
        resultText = text
        userInteractionStatus = status
        viewModelDidChange?(self)
    }
}
