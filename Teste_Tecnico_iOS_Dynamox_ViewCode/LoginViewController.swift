//
//  LoginViewController.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCode
//
//  Created by Vitor Gomes on 08/03/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Views
    
    private let helloLabel: UILabel = {
        let helloLabel = UILabel()
        
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        helloLabel.text = "Olá!"
        helloLabel.font = UIFont.boldSystemFont(ofSize: 24)
        helloLabel.textAlignment = .center
        
        return helloLabel
    }()
    
    private let userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        
        userNameTextField.placeholder = "Digite seu nome ou apelido"
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return userNameTextField
    }()
    
    private let dividerView: UIView = {
        let dividerView = UIView()
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .gray
        
        return dividerView
    }()
    
    private let startButton: UIButton = {
        let startButton = UIButton()
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.systemBlueBackgroundWhiteTitleStyle(title: "INICIAR")
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        return startButton
    }()
    
    private let versionLabel: UILabel = {
        let versionLabel = UILabel()
        
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        versionLabel.text = "Versão 1.0"
        versionLabel.font = .systemFont(ofSize: 12)
        versionLabel.textColor = .gray
        versionLabel.textAlignment = .center
        
        return versionLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: Functions
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(helloLabel)
        view.addSubview(userNameTextField)
        view.addSubview(dividerView)
        view.addSubview(startButton)
        view.addSubview(versionLabel)
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let eightyPercentWidth = screenWidth * 0.9
        
        NSLayoutConstraint.activate([
            helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            helloLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            
            userNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameTextField.topAnchor.constraint(equalTo: helloLabel.bottomAnchor, constant: 24),
            userNameTextField.heightAnchor.constraint(equalToConstant: 48),
            userNameTextField.widthAnchor.constraint(equalToConstant: eightyPercentWidth),
            
            dividerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dividerView.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.widthAnchor.constraint(equalToConstant: eightyPercentWidth),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 16),
            startButton.heightAnchor.constraint(equalToConstant: 48),
            startButton.widthAnchor.constraint(equalToConstant: eightyPercentWidth),
            
            versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            versionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 8)
        ])
    }
    
    @objc private func startButtonTapped() {
    }
}
