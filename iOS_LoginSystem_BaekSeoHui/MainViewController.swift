//
//  MainViewController.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/16/25.
//

import UIKit

final class MainViewController: UIViewController {
    private let mainView = MainView()
    
    
    private var userEmail: String
    
    init(email: String) {
        self.userEmail = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
    }
    
    
}
