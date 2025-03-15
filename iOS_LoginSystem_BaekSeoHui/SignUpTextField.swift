//
//  SignUpTextField.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/16/25.
//

import UIKit

final class SignUpTextField: UITextField {
    
    init(type: SignUpFieldType) {
        super.init(frame: .zero)
        setUpTextField()
        configureFor(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpTextField() {
        backgroundColor = .systemGray5
        layer.cornerRadius = 24
        font = UIFont.systemFont(ofSize: 18)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        leftViewMode = .always
        autocorrectionType = .no
        autocapitalizationType = .none
        clearButtonMode = .whileEditing
        heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func configureFor(type: SignUpFieldType) {
        switch type {
        case .email:
            placeholder = "이메일을 입력하세요."
            keyboardType = .emailAddress
            returnKeyType = .next
            setUpLeftIcon(systemName: "envelope")
            
        case .password:
            placeholder = "비밀번호를 입력하세요."
            isSecureTextEntry = true
            returnKeyType = .next
            setUpLeftIcon(systemName: "lock")
            
        case .confirmPassword:
            placeholder = "비밀번호를 다시 입력하세요."
            isSecureTextEntry = true
            returnKeyType = .next
            setUpLeftIcon(systemName: "lock.fill")
            
        case .nickname:
            placeholder = "닉네임을 입력하세요."
            returnKeyType = .done
            setUpLeftIcon(systemName: "person")
        }
    }
    
    private func setUpLeftIcon(systemName: String) {
        let iconImage = UIImage(systemName: systemName)
        let iconImageView = UIImageView(image: iconImage)
        iconImageView.tintColor = .darkGray
        iconImageView.contentMode = .scaleAspectFit
        
        let iconSize: CGFloat = 20
        iconImageView.frame = CGRect(x: 12, y: 0, width: iconSize, height: iconSize)
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: iconSize + 24, height: iconSize))
        containerView.addSubview(iconImageView)
        
        leftView = containerView
    }
}
