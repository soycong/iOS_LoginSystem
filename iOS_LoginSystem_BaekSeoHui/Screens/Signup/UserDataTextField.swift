//
//  SignUpTextField.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/16/25.
//

import UIKit

// 사용자 데이터 입력용 커스텀 텍스트필드
final class UserDataTextField: UITextField {
    
    init(type: UserDataTextFieldType, textFieldBackgroundColor: UIColor = .systemGray5) {
        super.init(frame: .zero)
        setUpTextField(textFieldBackgroundColor)
        configureFor(type: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpTextField(_ textFieldBackgroundColor: UIColor) {
        backgroundColor = textFieldBackgroundColor
        layer.cornerRadius = 24
        font = .systemFont(ofSize: 16)
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        leftViewMode = .always
        autocorrectionType = .no
        autocapitalizationType = .none
        clearButtonMode = .whileEditing
        heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func setUpLeftIcon(systemName: String) {
        let iconImage = UIImage(systemName: systemName)
        let iconImageView = UIImageView(image: iconImage)
        iconImageView.tintColor = .systemGray3
        iconImageView.contentMode = .scaleAspectFit
        
        let iconSize: CGFloat = 20
        iconImageView.frame = CGRect(x: 12, y: 0, width: iconSize, height: iconSize)
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: iconSize + 24, height: iconSize))
        containerView.addSubview(iconImageView)
        
        leftView = containerView
    }
    
    private func configureFor(type: UserDataTextFieldType) {
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
}
