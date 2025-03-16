//
//  ViewController.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/15/25.
//

import UIKit
import RxSwift
import RxCocoa

final class InitialViewController: UIViewController {
    
    private let initialView = InitialView()
    private let viewModel = InitialViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = initialView
        bind()
    }
    
    private func bind() {
        initialView.startButton.rx.tap
            .bind(to: viewModel.buttonTapped)
            .disposed(by: disposeBag)
        
        // 사용자 존재 여부에 따른 화면 전환
        viewModel.userCheckResult
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                
                if result.exists, let email = result.email {
                    toNextView(userEmail: email)
                } else {
                    toNextView()
                }
            })
            .disposed(by: disposeBag)
    }

    private func toNextView(userEmail: String = "") {
        
        if userEmail.isEmpty { // 저장된 사용자가 없을 경우
            let signUpViewController = SignUpViewController()
            
            signUpViewController.modalPresentationStyle = .fullScreen
            self.present(signUpViewController, animated: true, completion: nil)
        } else { // 저장된 사용자가 있을 경우
            let mainViewController = MainViewController(email: userEmail)
            
            mainViewController.modalPresentationStyle = .fullScreen
            self.present(mainViewController, animated: true, completion: nil)
        }
    }
}
