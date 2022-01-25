//
//  WebViewController.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 18.01.2022.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKUIDelegate {
    
    var viewModel: WebViewModelProtocol!
    
    let webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupWebViewConstraints()
        loadUrl()
    }
    
    private func loadUrl() {
        guard let request = viewModel.urlRequest else { return }
        webView.load(request)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(webView)
    }
    
    private func setupWebViewConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leftAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            webView.bottomAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            webView.rightAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}
