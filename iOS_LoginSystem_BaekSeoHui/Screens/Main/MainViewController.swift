//
//  MainViewController.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/16/25.
//

import UIKit
import RxSwift
import RxCocoa

/// 로그인 성공 화면
final class MainViewController: UIViewController {
    private var mainView: MainView!
    private let viewModel: MainViewModel
    private let disposeBag = DisposeBag()
    
    init(email: String) {
        self.viewModel = MainViewModel(email: email)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProfieView()
        bind()
    }
    
    // 사용자 프로필 화면 설정
    private func configureProfieView() {
        viewModel.userProfile
            .take(1)
            .subscribe(onNext: { [weak self] profile in
                guard let self = self else { return }
                
                self.mainView = MainView(nickname: profile.nickname, email: profile.email)
                self.view = self.mainView
            })
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        mainView.logOutButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showConfirmationAlert(isLogout: true)
            })
            .disposed(by: disposeBag)
        
        mainView.deleteAccountButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showConfirmationAlert(isLogout: false)
            })
            .disposed(by: disposeBag)
        
        // 로그아웃 완료
        viewModel.logOutComplete
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                toInitialView()
            })
            .disposed(by: disposeBag)
        
        // 회원탈퇴 완료
        viewModel.deleteAccountComplete
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                toInitialView()
            })
            .disposed(by: disposeBag)
    }
    
    /// 초기 화면으로 이동
    private func toInitialView() {
        let initialViewController = InitialViewController()
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = initialViewController
            
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
    
    // 로그아웃, 회원탈퇴 Alert
    private func showConfirmationAlert(isLogout: Bool) {
        let title = isLogout ? "로그아웃" : "회원탈퇴"
        let message = isLogout ? "로그아웃 하시겠습니까?" : "회원탈퇴 하시겠습니까?"
        let confirmTitle = "확인"
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: confirmTitle, style: .destructive, handler: { [weak self] _ in
            guard let self = self else { return }
            
            if isLogout {
                self.viewModel.logOutButtonTapped.onNext(())
            } else {
                self.viewModel.deleteAccountButtonTapped.onNext(())
            }
        }))
        
        present(alert, animated: true)
    }
}
