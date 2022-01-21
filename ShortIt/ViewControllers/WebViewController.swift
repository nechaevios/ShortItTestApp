//
//  WebViewController.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 18.01.2022.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKUIDelegate {
    
    var urlString: String!
    
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupWebViewConstraints()
        
        let myURL = URL(string: urlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
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
