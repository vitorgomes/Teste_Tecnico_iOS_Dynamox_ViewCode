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
        
        restartButton.dynamoxBlueBackgroundWhiteTitleRoundedRectangleShapeStyle(title: "REINICIAR")
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        
        return restartButton
    }()
    
    private let tableTitleLabel: UILabel = {
        let tableTitleLabel = UILabel()
        
        tableTitleLabel.text = "Tabela de Scores"
        tableTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        tableTitleLabel.textAlignment = .center
        tableTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return tableTitleLabel
    }()
    
    private let scoreTableView: UITableView = {
        let scoreTableView = UITableView()
        
        scoreTableView.translatesAutoresizingMaskIntoConstraints = false
        
        return scoreTableView
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
        
        navigationItem.hidesBackButton = true
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        scoreLabel.text = "\(scoreViewModel.userName) acertou \(scoreViewModel.score) perguntas"
        
        view.addSubview(scoreLabel)
        view.addSubview(restartButton)
        view.addSubview(tableTitleLabel)
        view.addSubview(scoreTableView)
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let restartButtonWidth = screenWidth * 0.9
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restartButton.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 16),
            restartButton.heightAnchor.constraint(equalToConstant: 48),
            restartButton.widthAnchor.constraint(equalToConstant: restartButtonWidth),
            
            tableTitleLabel.topAnchor.constraint(equalTo: restartButton.bottomAnchor, constant: 16),
            tableTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            scoreTableView.topAnchor.constraint(equalTo: tableTitleLabel.bottomAnchor, constant: 16),
            scoreTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scoreTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scoreTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scoreTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        scoreTableView.dataSource = self
        scoreTableView.delegate = self
    }
    
    @objc private func restartButtonTapped() {
        let splashLoginViewController = SplashLoginViewController()
        splashLoginViewController.modalPresentationStyle = .fullScreen
        present(splashLoginViewController, animated: true)
    }
}

extension ScoreViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreViewModel.fetchPlayers()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let players = scoreViewModel.fetchPlayers() {
            let player = players[indexPath.row]
            cell.textLabel?.text = "Username: \(player.userName ?? ""), Score: \(player.score)"
        }
        
        return cell
    }
}
