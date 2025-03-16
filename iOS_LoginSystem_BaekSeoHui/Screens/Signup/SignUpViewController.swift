//
//  SignUpViewController.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/15/25.
//

import UIKit
import RxSwift
import RxCocoa

/// 회원가입 화면
final class SignUpViewController: UIViewController {
    private let signUpView = SignUpView()
    private let viewModel = SignUpViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = signUpView
        bind()
        setupKeyboardGesture()
    }
    
    private func bind() {
        // 입력 필드
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
        
        // 버튼
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
        
        // 화면 닫기
        viewModel.dismissSignUpView
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    // 다음 화면 이동
    private func toNextView(userEmail: String) {
        if userEmail.isEmpty { // 저장된 사용자가 없을 경우 -> 알림창
            let error = NSError(domain: "회원가입 오류", code: 100, userInfo: [NSLocalizedDescriptionKey: "유효한 이메일 정보가 없습니다."])
            showAlert(error)
            
        } else { // 저장된 사용자가 있을 경우
            let mainViewController = MainViewController(email: userEmail)
            
            mainViewController.modalPresentationStyle = .fullScreen
            self.present(mainViewController, animated: true, completion: nil)
        }
    }
    
    // 텍스트필드 오류 알림 표시
    private func showAlert(_ error: Error) {
        let alert = UIAlertController(
            title: "회원가입 실패",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }
    
    // 화면 터치 시 키보드 제거
    private func setupKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
}
