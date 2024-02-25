//
//  ScoreViewModel.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCode
//
//  Created by Vitor Gomes on 25/02/24.
//

import Foundation
import UIKit
import CoreData

class ScoreViewModel {
    let userName: String
    let score: Int
    
    init(userName: String, score: Int) {
        self.userName = userName
        self.score = score
    }
    
    func fetchPlayers() -> [Player]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Erro ao obter o AppDelegate")
            return nil
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Player>(entityName: "Player")
        
        do {
            let players = try context.fetch(fetchRequest)
            return players
        } catch {
            print("Erro ao recuperar jogadores: \(error)")
            return nil
        }
    }
}
