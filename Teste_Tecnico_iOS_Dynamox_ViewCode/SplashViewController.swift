//
//  SplashViewController.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCode
//
//  Created by Vitor Gomes on 25/02/24.
//

import UIKit

class SplashViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "dynamox_logo")
        
        return logoImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        animationSplash()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func animationSplash() {
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseInOut, animations:  {
            self.logoImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (finished) in
            self.navigationController?.pushViewController(HomeViewController(), animated: true)
        }
    }
}
