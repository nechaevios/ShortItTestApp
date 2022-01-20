//
//  MainViewController.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 15.01.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    var viewModel: MainViewModelProtocol! {
        didSet {
            self.viewModel.viewModelDidChange = {
               [unowned self] viewModel in
                self.resultLabel.text = self.viewModel.resultLabelText
                self.resultLabel.isUserInteractionEnabled = self.viewModel.resultLabelState
            }
        }
    }
    
    private lazy var upperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.textLabelData
        label.textColor = .white
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = viewModel.textFieldPlaceholder
        textField.returnKeyType = .done
        textField.keyboardType = .URL
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.textColor = .white
        resultLabel.numberOfLines = 0
        return resultLabel
    }()
    
    private lazy var composeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(
            red: 252 / 255,
            green: 51 / 255,
            blue: 41 / 255,
            alpha: 1)
        button.tintColor = .white
        button.layer.cornerRadius = 14
        button.setTitle(viewModel.buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(fetchShortUrl), for: .touchUpInside)
        return button
    }()
    
    private lazy var upperStack = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        
        setupUI()
        setupConstraints()
        setupDelegates()
        resultLabelTapGestureSetup()
    }
    
    
    @objc private func fetchShortUrl() {
        viewModel.fetchShortUrl(urlString: textField.text)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = viewModel.navigationItemText
        resultLabel.text = viewModel.resultLabelText
        
        setupUpperStackView()
        view.addSubview(upperStack)
    }
    
    private func setupUpperStackView() {
        upperStack = UIStackView(
            arrangedSubviews: [
                textLabel,
                textField,
                resultLabel,
                composeButton
            ])
        
        upperStack.axis = .vertical
        upperStack.spacing = 20
        upperStack.layer.cornerRadius = 8
        upperStack.distribution = .fill
        upperStack.backgroundColor = .blue
        upperStack.alignment = .center
        
        upperStack.isLayoutMarginsRelativeArrangement = true
        upperStack.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 20,
            leading: 10,
            bottom: 20,
            trailing: 10
        )
    }
    
    //MARK: - Constraints
    
    private func setupConstraints() {
        setupUpperStackViewConstraints()
        setupComposeButtonConstraints()
        setupTextFieldConstraints()
    }
    
    private func setupUpperStackViewConstraints() {
        upperStack.translatesAutoresizingMaskIntoConstraints = false
        upperStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        upperStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        upperStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
    }
    
    private func setupComposeButtonConstraints() {
        composeButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        composeButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setupTextFieldConstraints() {
        textField.widthAnchor.constraint(equalToConstant: 240).isActive = true
    }
}

// MARK: - UITextFieldDelegate

extension MainViewController: UITextFieldDelegate {
    private func setupDelegates() {
        textField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        fetchShortUrl()
        return true
    }
}

// MARK: - resultLabelTapGestureSetup

extension MainViewController {
    private func resultLabelTapGestureSetup() {
        let resultLabelTap = UITapGestureRecognizer(target: self, action: #selector(openWebView))
        resultLabel.addGestureRecognizer(resultLabelTap)
    }
    
    @objc private func openWebView() {
        let webVC = WebViewController()
        webVC.urlString = viewModel.resultLabelText
        navigationController?.pushViewController(webVC, animated: true)
    }
}
