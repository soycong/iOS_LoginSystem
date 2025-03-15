//
//  InitialViewModel.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/16/25.
//

import RxSwift
import RxCocoa

final class InitialViewModel {
    let buttonTapped = PublishSubject<Void>()
    
    let userCheckResult = PublishSubject<(exists: Bool, email: String?)>()
    
    private let userDataManager: UserDataManager
    private let disposeBag = DisposeBag()
    
    init(userDataManager: UserDataManager = UserDataManager()) {
        self.userDataManager = userDataManager
        checkUser()
    }
    
    private func checkUser() {
        buttonTapped
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                
                let users = self.userDataManager.readAllUsers()
                
                if let firstUser = users.first {
                    self.userCheckResult.onNext((true, firstUser.email))
                } else {
                    self.userCheckResult.onNext((false, nil))
                }
            })
            .disposed(by: disposeBag)
    }
}
