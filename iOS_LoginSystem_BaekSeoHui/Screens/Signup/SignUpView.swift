//
//  SignUpView.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/15/25.
//

import UIKit
import SnapKit

final class SignUpView: UIView {
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "xmark")
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 22)
        button.configuration = config
        button.tintColor = .black
        
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "회원가입"
        label.textColor = .main
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 30, weight: .black)
        
        return label
    }()
    
    private let userEmailTextField = UserDataTextField(type: .email)
    private let userPasswordTextField = UserDataTextField(type: .password)
    private let userConfirmPasswordTextField = UserDataTextField(type: .confirmPassword)
    private let userNicknameTextField = UserDataTextField(type: .nickname)
    
    var signUpButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("회원가입하기", for: .normal)
        button.setTitleColor(.sub, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
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
    
    /// 외부에서 텍스트필드에 접근하기 위한 프로퍼티
    var emailTextField: UITextField { return userEmailTextField }
    var passwordTextField: UITextField { return userPasswordTextField }
    var confirmPasswordTextField: UITextField { return userConfirmPasswordTextField }
    var nicknameTextField: UITextField { return userNicknameTextField }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .sub
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(dismissButton)
        addSubview(verticalStackView)
        
        dismissButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.centerX.centerY.equalToSuperview()
        }
    }
}
