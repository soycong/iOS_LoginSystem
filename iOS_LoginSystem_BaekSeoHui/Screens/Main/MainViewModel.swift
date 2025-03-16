//
//  MainViewModel.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/16/25.
//

import RxSwift
import RxCocoa

final class MainViewModel {
    // 입력
    let logOutButtonTapped = PublishSubject<Void>()
    let deleteAccountButtonTapped = PublishSubject<Void>()
    
    // 출력
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
    
    // 사용자 프로필 조회
    private func readUserProfile() {
        let user = userDataManager.readUserData(email: email)
        userProfile.accept((
            nickname: user?.nickname ?? "사용자",
            email: user?.email ?? email
        ))
    }
    
    // 로그아웃 처리
    private func logOut() {
        logOutButtonTapped
            .bind(to: logOutComplete)
            .disposed(by: disposeBag)
    }
    
    // 회원탈퇴 처리
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
