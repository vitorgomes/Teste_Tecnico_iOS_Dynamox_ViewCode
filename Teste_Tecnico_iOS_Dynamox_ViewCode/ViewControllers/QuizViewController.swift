//
//  QuizViewController.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCode
//
//  Created by Vitor Gomes on 24/02/24.
//

import UIKit

class QuizViewController: UIViewController {
    
    private let quizViewModel: QuizViewModel
    
    private let loadingIndicatorView: UIActivityIndicatorView = {
        let loadingIndicatorView = UIActivityIndicatorView(style: .large)
        
        loadingIndicatorView.color = .white
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        return loadingIndicatorView
    }()
    
    private let loadingBackgroundView: UIView = {
        let loadingBackgroundView = UIView()
        
        loadingBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        loadingBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        return loadingBackgroundView
    }()
    
    private let questionLabel: UILabel = {
        let questionLabel = UILabel()
        
        questionLabel.textAlignment = .center
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.numberOfLines = 0
        
        return questionLabel
    }()
    
    private let optionsPickerView: UIPickerView = {
        let optionsPickerView = UIPickerView()
        
        optionsPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        return optionsPickerView
    }()
    
    private let submitButton: UIButton = {
        let submitButton = UIButton(type: .system)
        
        submitButton.dynamoxBlueBackgroundWhiteTitleRoundedRectangleShapeStyle(title: "RESPONDER")
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        
        return submitButton
    }()
    
    private let resultLabel: UILabel = {
        let resultLabel = UILabel()
        
        resultLabel.textAlignment = .center
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.numberOfLines = 0
        resultLabel.isHidden = true
        
        return resultLabel
    }()
    
    init(viewModel: QuizViewModel) {
        self.quizViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fetchQuestion()
    }
    
    func setupViews() {
        
        view.backgroundColor = .white
        
        view.addSubview(questionLabel)
        view.addSubview(optionsPickerView)
        view.addSubview(submitButton)
        view.addSubview(resultLabel)
        view.addSubview(loadingIndicatorView)
        view.addSubview(loadingBackgroundView)
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let submitButtonWidth = screenWidth * 0.9
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            optionsPickerView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 16),
            optionsPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            optionsPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            submitButton.topAnchor.constraint(equalTo: optionsPickerView.bottomAnchor, constant: 16),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 48),
            submitButton.widthAnchor.constraint(equalToConstant: submitButtonWidth),
            
            resultLabel.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 16),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loadingIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            loadingBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        loadingBackgroundView.isHidden = true
        
        loadingIndicatorView.startAnimating()
        loadingIndicatorView.isHidden = true
        
        optionsPickerView.dataSource = self
        optionsPickerView.delegate = self
    }
    
    private func fetchQuestion() {
        showLoadingIndicator()
        
        quizViewModel.fetchQuestion { [weak self] question in
            guard let self = self else { return }
            if let question = question {
                DispatchQueue.main.async {
                    self.questionLabel.text = question.statement
                    self.optionsPickerView.reloadAllComponents()
                    self.hideLoadingIndicator()
                }
            }
        }
    }
    
    @objc private func submitButtonTapped() {
        let selectedOptionIndex = optionsPickerView.selectedRow(inComponent: 0)
        guard let selectedOption = quizViewModel.currentQuestion?.options[selectedOptionIndex] else { return }
        
        quizViewModel.submitAnswer(answer: selectedOption) { [weak self] result in
            DispatchQueue.main.async {
                self?.resultLabel.isHidden = false
                self?.resultLabel.text = result ? "Resposta correta!" : "Resposta incorreta."
                
                if result {
                    self?.quizViewModel.incrementScore()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.resultLabel.isHidden = true
                    self?.quizViewModel.incrementQuestionCounter()
                    
                    if self?.quizViewModel.shouldNavigateToScoreViewController() ?? false {
                        self?.quizViewModel.savePlayer(username: self?.quizViewModel.userName ?? "", score: self?.quizViewModel.score ?? 0) // TODO: Treat the safe way later. Forced now only for tests purposes
                        self?.navigateToScoreViewController()
                    } else {
                        self?.fetchQuestion()
                    }
                }
            }
        }
    }
    
    private func navigateToScoreViewController() {
        let scoreViewModel = ScoreViewModel(userName: quizViewModel.userName, score: quizViewModel.score)
        let scoreViewController = ScoreViewController(viewModel: scoreViewModel)

        scoreViewController.modalPresentationStyle = .fullScreen
        present(scoreViewController, animated: true)
    }
    
    private func showLoadingIndicator() {
        loadingBackgroundView.isHidden = false
        loadingIndicatorView.isHidden = false
        view.isUserInteractionEnabled = false
    }
    
    private func hideLoadingIndicator() {
        loadingBackgroundView.alpha = 1.0
        loadingBackgroundView.isHidden = true
        loadingIndicatorView.isHidden = true
        view.isUserInteractionEnabled = true
    }
}

extension QuizViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return quizViewModel.currentQuestion?.options.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return quizViewModel.currentQuestion?.options[row]
    }
}
