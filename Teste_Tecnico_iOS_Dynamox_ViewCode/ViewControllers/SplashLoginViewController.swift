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
        cubeImage.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        
        return cubeImage
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Quiz"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        
        return titleLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        animateCube()
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
    
    private func animateCube() {
        UIView.animate(withDuration: 0.8, delay: 0, options: [.autoreverse, .curveEaseInOut], animations: {
            self.cubeImage.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        }) { _ in
            self.moveCubeLeft()
        }
    }
    
    private func moveCubeLeft() {
        UIView.animate(withDuration: 0.5) {
            NSLayoutConstraint.activate([self.cubeImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -30)])
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.titleLabelAppearance()
        }
    }
    
    private func titleLabelAppearance() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: cubeImage.trailingAnchor, constant: -40),
            titleLabel.centerYAnchor.constraint(equalTo: cubeImage.centerYAnchor)
        ])
        
        self.view.layoutIfNeeded()
        self.moveCubeAndTitleUp()
        presentLoginViewControllerModally()
    }
    
    private func presentLoginViewControllerModally() {
        let loginViewController = LoginViewController()
        let navController = UINavigationController(rootViewController: loginViewController)

        navController.modalPresentationStyle = .pageSheet
        navController.sheetPresentationController?.detents = [.medium()]
        
        present(navController, animated: true)
    }
    
    private func moveCubeAndTitleUp() {
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        let screenHeightTwentyFivePercent = screenHeight * -0.25
        
        UIView.animate(withDuration: 0.5) {
            NSLayoutConstraint.activate([
                self.cubeImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: screenHeightTwentyFivePercent),
                self.titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: screenHeightTwentyFivePercent)
            ])
            
            self.view.layoutIfNeeded()
        }
    }
}
