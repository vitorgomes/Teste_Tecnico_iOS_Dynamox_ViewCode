//
//  UIButtonCustomStyle.swift
//  Teste_Tecnico_iOS_Dynamox_ViewCode
//
//  Created by Vitor Gomes on 25/02/24.
//

import UIKit

extension UIButton {
    func systemBlueBackgroundWhiteTitleStyle(title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor.systemBlue
        translatesAutoresizingMaskIntoConstraints = false
    }
}
