//
//  ScoreViewController.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCode
//
//  Created by Vitor Gomes on 24/02/24.
//

import UIKit

class ScoreViewController: UIViewController {
    
    var userName: String?
    var score: Int?
    
    private let scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        
        scoreLabel.textAlignment = .center
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return scoreLabel
    }()
    
    private let restartButton: UIButton = {
        let restartButton = UIButton(type: .system)
        
        restartButton.setTitle("Reiniciar", for: .normal)
        restartButton.setTitleColor(.white, for: .normal)
        restartButton.backgroundColor = UIColor.systemBlue
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        
        return restartButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        if let userName = userName, let score = score {
            scoreLabel.text = "\(userName) acertou \(score) perguntas"
        } else {
            scoreLabel.text = "Nome e pontuação não encontrados"
        }
        
        view.addSubview(scoreLabel)
        view.addSubview(restartButton)
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let restartButtonWidth = screenWidth * 0.8
        
        NSLayoutConstraint.activate([
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            
            restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restartButton.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 16),
            restartButton.heightAnchor.constraint(equalToConstant: 48),
            restartButton.widthAnchor.constraint(equalToConstant: restartButtonWidth)
        ])
    }
    
    @objc private func restartButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}
