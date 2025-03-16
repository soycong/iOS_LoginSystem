//
//  MainViewController.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/16/25.
//

import UIKit
import RxSwift
import RxCocoa

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
            .bind(to: viewModel.logOutButtonTapped)
            .disposed(by: disposeBag)
        
        mainView.deleteAccountButton.rx.tap
            .bind(to: viewModel.deleteAccountButtonTapped)
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
}
