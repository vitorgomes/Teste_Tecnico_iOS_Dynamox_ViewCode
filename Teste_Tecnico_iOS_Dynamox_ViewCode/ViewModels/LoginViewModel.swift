//
//  HomeViewModel.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCode
//
//  Created by Vitor Gomes on 25/02/24.
//

import Foundation

class LoginViewModel {
    var userName: String = ""
    
    func startQuiz(completion: @escaping (QuizViewController) -> Void) {
        let quizViewModel = QuizViewModel(userName: userName)
        let quizViewController = QuizViewController(viewModel: quizViewModel)
        
        completion(quizViewController)
    }
}
