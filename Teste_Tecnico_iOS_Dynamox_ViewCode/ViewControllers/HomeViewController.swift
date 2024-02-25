//
//  ViewController.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCode
//
//  Created by Vitor Gomes on 24/02/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let homeViewModel = HomeViewModel()
    
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
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor.systemBlue
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
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let startButtonWidth = screenWidth * 0.8
        let userNameLabelWidth = screenWidth * 0.8
        
        NSLayoutConstraint.activate([
            userNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            userNameTextField.widthAnchor.constraint(equalToConstant: userNameLabelWidth),
            
            startButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 16),
            startButton.widthAnchor.constraint(equalToConstant: startButtonWidth),
            startButton.heightAnchor.constraint(equalToConstant: 48),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func startButtonTapped() {
        guard let userName = userNameTextField.text else { return }
        
        homeViewModel.userName = userName
        homeViewModel.startQuiz { [weak self] quizViewController in
            self?.navigationController?.pushViewController(quizViewController, animated: true)
        }
    }
}

