//
//  QuizViewController.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCode
//
//  Created by Vitor Gomes on 24/02/24.
//

import UIKit

class QuizViewController: UIViewController {
    
    let quizManager = QuizManager()
    
    var userName: String?
    var question: Question?
    var questionCounter = 0
    var score = 0
    
//    private let activityIndicator: UIActivityIndicatorView = {
//        let activityIndicator = UIActivityIndicatorView()
//
//        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//        
//        return activityIndicator
//    }()
//    
//    private let backgroundView: UIView = {
//        let backgroundView = UIView()
//        
//        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        backgroundView.translatesAutoresizingMaskIntoConstraints = false
//        
//        return backgroundView
//    }()
    
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
        
        submitButton.setTitle("Responder", for: .normal)
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.backgroundColor = UIColor.systemBlue
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
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
//        view.addSubview(activityIndicator)
//        view.addSubview(backgroundView)
//        
//        view.insertSubview(backgroundView, belowSubview: activityIndicator)
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let submitButtonWidth = screenWidth * 0.8
        
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
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
//            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            
//            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
//            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        optionsPickerView.dataSource = self
        optionsPickerView.delegate = self
    }
    
//    func startAnimatingActivityIndicator() {
//        activityIndicator.startAnimating()
//        backgroundView.isHidden = false
//    }
//    
//    func stopAnimatingActivityIndicator() {
//        activityIndicator.stopAnimating()
//        backgroundView.isHidden = true
//    }
    
    func fetchQuestion() {
        // startAnimatingActivityIndicator()
        
        quizManager.fetchQuestion { [weak self] question, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error fetching question: \(error)")
            } else if let question = question {
                DispatchQueue.main.async {
                    self.question = question
                    self.questionLabel.text = question.statement
                    self.optionsPickerView.reloadAllComponents()
                }
            }
        }
        // stopAnimatingActivityIndicator()
    }
    
    @objc private func submitButtonTapped() {
        // startAnimatingActivityIndicator()
        
        guard let question = question else { return }
        let selectedOptionIndex = optionsPickerView.selectedRow(inComponent: 0)
        let selectedOption = question.options[selectedOptionIndex]
        
        quizManager.submitAnswer(questionId: question.id, answer: selectedOption) { [weak self] result, error in
            if let error = error {
                print("Error submiting answer: \(error)")
            } else if let result = result {
                DispatchQueue.main.async {
                    self?.resultLabel.isHidden = false
                    self?.resultLabel.text = result ? "Resposta correta!" : "Resposta incorreta."
                    
                    if result {
                        self?.score += 1
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self?.resultLabel.isHidden = true
                        self?.questionCounter += 1
                        if self?.questionCounter == 10 {
                            self?.navigateToScoreViewController()
                        } else {
                            self?.fetchQuestion()
                        }
                    }
                }
            }
        }
        // stopAnimatingActivityIndicator()
    }
    
    func navigateToScoreViewController() {
        let scoreViewController = ScoreViewController()
        
        scoreViewController.userName = userName
        scoreViewController.score = score
        navigationController?.pushViewController(scoreViewController, animated: true)
    }
}

extension QuizViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return question?.options.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return question?.options[row]
    }
}
