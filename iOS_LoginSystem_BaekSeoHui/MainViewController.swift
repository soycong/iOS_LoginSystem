//
//  MainViewController.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/16/25.
//

import UIKit

final class MainViewController: UIViewController {
    private let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
    }
}
