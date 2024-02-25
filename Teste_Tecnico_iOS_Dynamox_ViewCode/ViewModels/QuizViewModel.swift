//
//  QuizViewModel.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCode
//
//  Created by Vitor Gomes on 25/02/24.
//

import Foundation
import UIKit

class QuizViewModel {
    private let quizManager = QuizManager()

    private var question: Question?
    private(set) var userName: String
    private var questionCounter = 0
    private(set) var score = 0
    
    init(userName: String) {
        self.userName = userName
    }
    
    var currentQuestion: Question? {
        return question
    }
    
    func fetchQuestion(completion: @escaping (Question?) -> Void) {
        quizManager.fetchQuestion { [weak self] question, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching question: \(error)")
                completion(nil)
            } else if let question = question {
                self.question = question
                completion(question)
            }
        }
    }
    
    func submitAnswer(answer: String, completion: @escaping (Bool) -> Void) {
        guard let question = question else { return }
        quizManager.submitAnswer(questionId: question.id, answer: answer) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                print("Error submitting answer: \(error)")
                completion(false)
            } else if let result = result {
                if result {
                    self.incrementScore()
                }
                completion(result)
            }
        }
    }
    
    func shouldNavigateToScoreViewController() -> Bool {
        return questionCounter == 10
    }
    
    func incrementScore() {
        score += 1
    }
    
    func incrementQuestionCounter() {
        questionCounter += 1
    }
}
