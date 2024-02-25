//
//  Question.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCode
//
//  Created by Vitor Gomes on 24/02/24.
//

import Foundation

struct Question: Codable {
    let id: String
    let statement: String
    let options: [String]
}
