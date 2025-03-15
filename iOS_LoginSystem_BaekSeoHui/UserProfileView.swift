//
//  UserProfileView.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/16/25.
//

import UIKit
import SnapKit

final class UserProfileView: UIView {
    
    private var nickname: String
    private var email: String
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        
        label.text = "\(nickname)님 환영합니다!"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        
        label.text = "\(email)"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [greetingLabel,
                                                       emailLabel])
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    init(nickname: String, email: String) {
        self.nickname = nickname
        self.email = email
        
        super.init(frame: .zero)
        backgroundColor = .sub
        layer.cornerRadius = 24

        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(profileStackView)
        
        profileStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview().inset(40)
            make.centerX.centerY.equalToSuperview()
        }
    }
}
