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
            setTextAndUserInteraction(with: "Empty URL", and: nil)
            return
        }
        
        if checkValid(urlString) {
            resultText = "..."
            setTextAndUserInteraction(with: "...", and: nil)
            
            NetworkManager.shared.fetchShortUrl(longUrl: urlString) { [ weak self ] responseModel, error in
                if error == nil {
                    guard let responseModel = responseModel else { return }
                    StorageManager.shared.saveResponse(response: responseModel)
                    self?.setTextAndUserInteraction(with: responseModel.shorturl, and: true)
                } else {
                    self?.setTextAndUserInteraction(with: nil, and: nil)
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
                setTextAndUserInteraction(with: "Url is not valid! Format: http(s)://url.com", and: nil)
                return false
            }
        }
    }
    
    private func setTextAndUserInteraction(with text: String?, and status: Bool?) {
        resultText = text ?? " "
        userInteractionStatus = status ?? false
        viewModelDidChange?(self)
    }
}
