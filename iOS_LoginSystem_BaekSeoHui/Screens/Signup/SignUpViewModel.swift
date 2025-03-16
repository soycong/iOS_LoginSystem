//
//  SignUpViewModel.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/16/25.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpViewModel {
    let emailInput = BehaviorRelay<String>(value: "")
    let passwordInput = BehaviorRelay<String>(value: "")
    let confirmPasswordInput = BehaviorRelay<String>(value: "")
    let nicknameInput = BehaviorRelay<String>(value: "")
    let signUpButtonTapped = PublishSubject<Void>()
    let dismissButtonTapped = PublishSubject<Void>()
    
    let signUpResult = PublishSubject<Result<User, SignUpError>>()
    let dismissSignUpView = PublishSubject<Void>()
    
    private let userDataManager: UserDataManager
    private let disposeBag = DisposeBag()
    
    init(userDataManager: UserDataManager = UserDataManager()) {
        self.userDataManager = userDataManager
        
        signUp()
        dismiss()
        
    }
    
    private func processSignUp(email: String, password: String,
                               confirmPassword: String, nickname: String) {
        // 기본 입력 확인
        if email.isEmpty || password.isEmpty || nickname.isEmpty {
            signUpResult.onNext(.failure(.emptyFields))
            return
        }
        
        // 이메일 형식 확인
        if !isValidEmail(email) {
            signUpResult.onNext(.failure(.invalidEmail))
            return
        }
        
        // 비밀번호 확인
        if password.count < 8 {
            signUpResult.onNext(.failure(.shortPassword))
            return
        }
        
        // 비밀번호 일치 확인
        if password != confirmPassword {
            signUpResult.onNext(.failure(.passwordMismatch))
            return
        }
        
        // 중복 이메일 확인
        if userDataManager.readUserData(email: email) != nil {
            signUpResult.onNext(.failure(.emailAlreadyExists))
            return
        }
        
        // 회원가입 진행
        userDataManager.createData(email: email, password: password, nickname: nickname)
        
        if let user = userDataManager.readUserData(email: email) {
            signUpResult.onNext(.success(user))
        } else {
            signUpResult.onNext(.failure(.saveFailed))
        }
    }
    
    // 이메일 유효성 검사
    private func isValidEmail(_ email: String) -> Bool {
        guard email.contains("@") else { return false }
        
        let components = email.split(separator: "@")
        guard let username = components.first, components.count == 2 else { return false }
        
        let isValidLength = (6...20).contains(username.count)
        let hasValidChars = username.allSatisfy { $0.isLowercase || $0.isNumber }
        let startsWithLetter = username.first?.isLowercase ?? false
        
        return isValidLength && hasValidChars && startsWithLetter
    }
    
    private func signUp() {
        signUpButtonTapped
            .withLatestFrom(Observable.combineLatest(
                emailInput, passwordInput, confirmPasswordInput, nicknameInput))
            .subscribe(onNext: { [weak self] email, password, confirmPassword, nickname in
                guard let self = self else { return }
                
                self.processSignUp(email: email, password: password,
                                   confirmPassword: confirmPassword, nickname: nickname)
            })
            .disposed(by: disposeBag)
    }
    
    private func dismiss() {
        dismissButtonTapped
            .subscribe(onNext: { [weak self] in
                self?.dismissSignUpView.onNext(())
            })
            .disposed(by: disposeBag)
    }
}
