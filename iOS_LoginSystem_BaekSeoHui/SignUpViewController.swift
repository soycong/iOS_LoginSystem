//
//  SignUpViewController.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/15/25.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpViewController: UIViewController {
    private let signUpView = SignUpView()
    private let viewModel = SignUpViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = signUpView
        bind()
    }
    
    private func bind() {
        signUpView.emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailInput)
            .disposed(by: disposeBag)
        
        signUpView.passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.passwordInput)
            .disposed(by: disposeBag)
        
        signUpView.confirmPasswordTextField.rx.text.orEmpty
            .bind(to: viewModel.confirmPasswordInput)
            .disposed(by: disposeBag)
        
        signUpView.nicknameTextField.rx.text.orEmpty
            .bind(to: viewModel.nicknameInput)
            .disposed(by: disposeBag)
        
        signUpView.signUpButton.rx.tap
            .bind(to: viewModel.signUpButtonTapped)
            .disposed(by: disposeBag)
        
        signUpView.dismissButton.rx.tap
            .bind(to: viewModel.dismissButtonTapped)
            .disposed(by: disposeBag)
        
        // 회원가입 결과 처리
        viewModel.signUpResult
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let user):
                    self?.toNextView(userEmail: user.email ?? "")
                    
                case .failure(let error):
                    self?.showAlert(error)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.dismissSignUpView
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func toNextView(userEmail: String) {
        if userEmail.isEmpty { // 저장된 사용자가 없을 경우
            let error = NSError(domain: "회원가입 오류", code: 100, userInfo: [NSLocalizedDescriptionKey: "유효한 이메일 정보가 없습니다."])
            showAlert(error)
        } else { // 저장된 사용자가 있을 경우
            let mainViewController = MainViewController(email: userEmail)
            
            mainViewController.modalPresentationStyle = .fullScreen
            self.present(mainViewController, animated: true, completion: nil)
        }
    }
    
    private func showAlert(_ error: Error) {
        let alert = UIAlertController(
            title: "회원가입 실패",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }
}
