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
        splashBackgroundImage.contentMode = .scaleAspectFill
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
        
        setupViews()
        animateSplash()
    }
    
    private func setupViews() {
        view.addSubview(splashBackgroundImage)
        view.addSubview(cubeImage)
        
        NSLayoutConstraint.activate([
            splashBackgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            splashBackgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            splashBackgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            splashBackgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            cubeImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cubeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func animateSplash() {
        
    }
}
