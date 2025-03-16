//
//  MainView.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/16/25.
//

import UIKit
import SnapKit

final class MainView: UIView {
    
    private let nickname: String
    private let email: String
    
    // 사용자 프로필 화면
    private(set) lazy var profileView: UserProfileView = {
        return UserProfileView(nickname: self.nickname, email: self.email)
    }()
    
    private(set) var logOutButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(.sub, for: .normal)
        button.setTitleColor(.sub.withAlphaComponent(0.6), for: .highlighted)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setCornerRadius()
        button.setButtonBackgroundColor()
        button.setHeight()
        
        return button
    }()
    
    private(set) var deleteAccountButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("회원탈퇴", for: .normal)
        button.setTitleColor(.sub, for: .normal)
        button.setTitleColor(.sub.withAlphaComponent(0.6), for: .highlighted)
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
    
    // 하단 배경 뷰
    private let backgroundView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .sub
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 24

        return view
    }()
    
    init(nickname: String, email: String) {
        self.nickname = nickname
        self.email = email
        
        super.init(frame: .zero)
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
