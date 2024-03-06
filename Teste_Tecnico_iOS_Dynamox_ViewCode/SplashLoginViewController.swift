//
//  SplashLoginViewController.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCode
//
//  Created by Vitor Gomes on 06/03/24.
//

import UIKit

class SplashLoginViewController: UIViewController {
    
    private let splashBackgroundImage: UIImageView = {
        let splashBackgroundImage = UIImageView()
        
        splashBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
        splashBackgroundImage.contentMode = .scaleAspectFit
        splashBackgroundImage.image = UIImage(named: "splashBackground")
        
        return splashBackgroundImage
    }()
    
    private let cubeImage: UIImageView = {
        let cubeImage = UIImageView()
        
        cubeImage.translatesAutoresizingMaskIntoConstraints = false
        cubeImage.contentMode = .scaleAspectFit
        cubeImage.image = UIImage(named: "dynaPredictCube")
        
        return cubeImage
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Quiz"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        
        return titleLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
