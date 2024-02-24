//
//  ViewController.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCode
//
//  Created by Vitor Gomes on 24/02/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        
        userNameTextField.placeholder = "Digite seu nome ou apelido"
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return userNameTextField
    }()
    
    private let startButton: UIButton = {
        let startButton = UIButton(type: .system)
        
        startButton.setTitle("Iniciar", for: .normal)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        return startButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(userNameTextField)
        view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            userNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            userNameTextField.widthAnchor.constraint(equalToConstant: 200),
            
            startButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func startButtonTapped() {
        guard let text = userNameTextField.text else { return }
        print("Texto digitado: \(text)")
    }
}

