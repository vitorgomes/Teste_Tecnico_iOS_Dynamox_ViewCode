//
//  Teste_Tecnico_iOS_Dynamox_ViewCodeTests.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCodeTests
//
//  Created by Vitor Gomes on 24/02/24.
//

import XCTest
@testable import Teste_Tecnico_iOS_Dynamox_ViewCode

final class Teste_Tecnico_iOS_Dynamox_ViewCodeTests: XCTestCase {
    
    var quizManager: QuizManagerProtocol!

    override func setUpWithError() throws {
        quizManager = QuizManagerStub()
    }

    override func tearDownWithError() throws {
        quizManager = nil
    }
    
    // If it is the first time you are running on simulator and fail, please try a second time, sometimes the API delays to return
    func testQuizManagerFetchQuestions_WhenValidRequest_ReturnsQuestions() {
        let expectation = XCTestExpectation(description: "Fetch questions")
        
        quizManager.fetchQuestion { question, error in
            XCTAssertNotNil(question)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testQuizManagerSubmitAnswer_WhenCorrectAnswer_ReturnsTrue() {
        let expectation = XCTestExpectation(description: "Submit correct answer")
        let questionId = "44"
        let correctAnswer = "Belchior, Gaspar e Baltazar"
        
        quizManager.submitAnswer(questionId: questionId, answer: correctAnswer) { isCorrect, error in
            XCTAssertTrue(isCorrect == true)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

}
