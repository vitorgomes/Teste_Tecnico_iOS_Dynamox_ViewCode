//
//  QuizManagerStub.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCode
//
//  Created by Vitor Gomes on 25/02/24.
//

import Foundation

class QuizManagerStub: QuizManagerProtocol {
    func fetchQuestion(completion: @escaping (Question?, Error?) -> Void) {
        let question = Question(id: "1", statement: "Sample Question", options: ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"])
        
        completion(question, nil)
    }
    
    func submitAnswer(questionId: String, answer: String, completion: @escaping (Bool?, Error?) -> Void) {
        completion(true, nil)
    }
}
