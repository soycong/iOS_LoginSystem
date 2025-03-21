//
//  InitialView.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/15/25.
//

import UIKit
import SnapKit

final class InitialView: UIView {

    var startButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(.main, for: .normal)
        button.setTitleColor(.main.withAlphaComponent(0.6), for: .highlighted)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setCornerRadius()
        button.backgroundColor = .sub
        button.setHeight()
        
        return button
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
        addSubview(startButton)
        
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.centerX.centerY.equalToSuperview()
        }
    }
}
