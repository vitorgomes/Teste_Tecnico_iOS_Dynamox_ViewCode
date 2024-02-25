//
//  ScoreViewController.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCode
//
//  Created by Vitor Gomes on 24/02/24.
//

import UIKit

class ScoreViewController: UIViewController {

    private let scoreViewModel: ScoreViewModel
    
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
    
    init(viewModel: ScoreViewModel) {
        self.scoreViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        let players = scoreViewModel.fetchPlayers() ?? []
        print("*** PLAYERS SCORES TABLE ***")
        for player in players {
            print("Username: \(player.userName), Score: \(player.score)")
        }
        
        navigationItem.hidesBackButton = true
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        scoreLabel.text = "\(scoreViewModel.userName) acertou \(scoreViewModel.score) perguntas"
        
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
