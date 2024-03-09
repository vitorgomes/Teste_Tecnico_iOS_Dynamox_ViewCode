//
//  UIButtonCustomStyle.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCode
//
//  Created by Vitor Gomes on 25/02/24.
//

import UIKit

extension UIButton {
    func dynamoxBlueBackgroundWhiteTitleRoundedRectangleShapeStyle(title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = .defaultBlue
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
