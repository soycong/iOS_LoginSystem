//
//  MainViewModel.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/16/25.
//

import RxSwift
import RxCocoa

final class MainViewModel {
    let logOutButtonTapped = PublishSubject<Void>()
    let deleteAccountButtonTapped = PublishSubject<Void>()
    
    let userProfile: BehaviorRelay<(nickname: String, email: String)>
    let logOutComplete = PublishSubject<Void>()
    let deleteAccountComplete = PublishSubject<Void>()
    
    private let userDataManager: UserDataManager
    private let disposeBag = DisposeBag()
    private let email: String
    
    init(email: String, userDataManager: UserDataManager = UserDataManager()) {
        self.email = email
        self.userDataManager = userDataManager
        self.userProfile = BehaviorRelay(value: ("", ""))
        
        readUserProfile()
        logOut()
        deleteAccount()
    }
    
    private func readUserProfile() {
        let user = userDataManager.readUserData(email: email)
        userProfile.accept((
            nickname: user?.nickname ?? "사용자",
            email: user?.email ?? email
        ))
    }
    
    private func logOut() {
        logOutButtonTapped
            .bind(to: logOutComplete)
            .disposed(by: disposeBag)
    }
    
    private func deleteAccount() {
        deleteAccountButtonTapped
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.userDataManager.deleteData(email: self.email)
                self.deleteAccountComplete.onNext(())
            })
            .disposed(by: disposeBag)
    }
}
