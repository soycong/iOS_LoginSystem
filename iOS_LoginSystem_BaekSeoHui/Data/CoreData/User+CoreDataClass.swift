//
//  User+CoreDataClass.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/16/25.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    public static let className = "User"
    public enum Key {
        static let email = "email"
        static let password = "password"
        static let nickname = "nickname"
    }
}
