//
//  MainView.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/16/25.
//

import UIKit
import SnapKit

final class MainView: UIView {
    
    private let profileView = UserProfileView(nickname: "soy", email: "email")
    
    private var logOutButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(.sub, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setCornerRadius()
        button.setButtonBackgroundColor()
        button.setHeight()
        
        return button
    }()
    
    private var deleteAccountButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("회원탈퇴", for: .normal)
        button.setTitleColor(.sub, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setCornerRadius()
        button.setButtonBackgroundColor()
        button.setHeight()
        
        return button
    }()
    
    private lazy var accountStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [logOutButton,
                                                       deleteAccountButton])
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .sub
        view.layer.cornerRadius = 24

        return view
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
        addSubview(profileView)
        addSubview(backgroundView)
        backgroundView.addSubview(accountStackView)
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(40)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(40)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        accountStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}
