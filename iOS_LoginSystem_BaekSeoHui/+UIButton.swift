//
//  +UIButton.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/15/25.
//

import UIKit

extension UIButton {
    func setButtonBackgroundColor() {
        backgroundColor = .main
    }
    
    func setCornerRadius() {
        layer.cornerRadius = 24
    }
     
    func setHeight() {
        heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}
