//
//  InitialView.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/15/25.
//

import UIKit
import SnapKit

final class InitialView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "로그인"
        label.textColor = .sub
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 30, weight: .black)
        
        return label
    }()
    
    private let userEmailTextField = UserDataTextField(type: .email, textFieldBackgroundColor: .sub)
    private let userPasswordTextField = UserDataTextField(type: .password, textFieldBackgroundColor: .sub)
    
    private var startButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(.main, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setCornerRadius()
        button.backgroundColor = .sub
        button.setHeight()
        
        return button
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       userEmailTextField,
                                                       userPasswordTextField,
                                                       startButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .main
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.centerX.centerY.equalToSuperview()
        }
    }
}
