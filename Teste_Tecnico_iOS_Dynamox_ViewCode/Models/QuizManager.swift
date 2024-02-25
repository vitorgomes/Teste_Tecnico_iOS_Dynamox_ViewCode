//
//  QuizManager.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCode
//
//  Created by Vitor Gomes on 24/02/24.
//

import Foundation

class QuizManager {
    private let baseURL = "https://quiz-api-bwi5hjqyaq-uc.a.run.app"
    
    func fetchQuestion(completion: @escaping (Question?, Error?) -> Void) {
        guard let url = URL(string: "\(baseURL)/question") else {
            let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
            completion(nil, error)
            return
        }
        // let url = URL(string: "\(baseURL)/question")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                let question = try JSONDecoder().decode(Question.self, from: data)
                completion(question, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
    func submitAnswer(questionId: String, answer: String, completion: @escaping (Bool?, Error?) -> Void) {
        let urlString = "\(baseURL)/answer?questionId=\(questionId)"
        
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let answerData: [String: String] = ["answer": answer]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: answerData)
            request.httpBody = jsonData
        } catch {
            completion(nil, error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(AnswerResponse.self, from: data)
                completion(response.result, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
