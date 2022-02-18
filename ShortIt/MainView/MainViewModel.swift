//
//  MainViewModel.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 19.01.2022.
//

import UIKit

protocol MainViewModelProtocol {
    var viewModelDidChange: ((MainViewModelProtocol) -> ())? { get set }
    var resultLabelText: String { get }
    var resultLabelState: Bool { get }
    
    func fetchShortUrl(urlString: String?)
    func openWebView(navController: NSObject)
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
    
    var viewModelDidChange: ((MainViewModelProtocol) -> ())?
    
    private var resultText: String = ResultText.none.rawValue
    private var userInteractionStatus = false
    private var apiResponse: BitLyResponse?
    
    private let textFieldValidationType: String.ValidationType = .url
    
    func openWebView(navController: NSObject) {
        let webViewController = WebViewController()
        guard let response = self.apiResponse else { return }
        webViewController.viewModel = WebViewModel(response: response)
        
        guard let navVC = navController as? UINavigationController else { return }
        navVC.pushViewController(webViewController, animated: true)
    }
    
    func fetchShortUrl(urlString: String?) {
        guard let urlString = urlString else { return }
        
        if urlString.isEmpty {
            setResultTextAndUserInteractionMode(as: ResultText.emptyString.rawValue)
            return
        }
        
        if checkValid(urlString) {
            setResultTextAndUserInteractionMode(as: ResultText.loading.rawValue)
            
            NetworkManager.shared.fetchShortUrl(longUrl: urlString) { [ weak self ] responseModel, error in
                if error == nil {
                    guard let responseModel = responseModel else { return }
                    StorageManager.shared.saveResponse(response: responseModel)
                    self?.apiResponse = responseModel
                    self?.setResultTextAndUserInteractionMode(as: responseModel.link, and: true)
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
                setResultTextAndUserInteractionMode(as: ResultText.invalid.rawValue)
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

// MARK: -- Result Label static data

extension MainViewModel {
    private enum ResultText: String {
        case none = " "
        case emptyString = "Empty URL"
        case loading = "..."
        case invalid = "Url is not valid! Format: http(s)://url.com"
    }
}
