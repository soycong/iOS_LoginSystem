//
//  SignUpView.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/15/25.
//

import UIKit
import SnapKit

final class SignUpView: UIView {
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        
        let image = UIImage(systemName: "chevron.left")
        button.setImage(image, for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "회원가입"
        label.textColor = .main
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 24)
        
        return label
    }()
    
    private let userEmailTextField = UserDataTextField(type: .email)
    private let userPasswordTextField = UserDataTextField(type: .password)
    private let userConfirmPasswordTextField = UserDataTextField(type: .confirmPassword)
    private let userNicknameTextField = UserDataTextField(type: .nickname)
    
    private var signUpButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("회원가입하기", for: .normal)
        button.setTitleColor(.sub, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setCornerRadius()
        button.setButtonBackgroundColor()
        
        return button
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       userEmailTextField,
                                                       userPasswordTextField,
                                                       userConfirmPasswordTextField,
                                                       userNicknameTextField,
                                                       signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .sub
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(backButton)
        addSubview(verticalStackView)
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(safeAreaLayoutGuide)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.centerX.centerY.equalToSuperview()
        }
        
    }
}
