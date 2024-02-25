//
//  QuizManagerProtocol.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCode
//
//  Created by Vitor Gomes on 25/02/24.
//

import Foundation

protocol QuizManagerProtocol {
    func fetchQuestion(completion: @escaping (Question?, Error?) -> Void)
    func submitAnswer(questionId: String, answer: String, completion: @escaping (Bool?, Error?) -> Void)
}
