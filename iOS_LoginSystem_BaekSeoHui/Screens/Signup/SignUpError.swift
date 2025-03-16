//
//  SignUpError.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/16/25.
//

import Foundation

// 회원가입 진행 중 발생할 수 있는 에라
enum SignUpError: LocalizedError {
    case emptyFields
    case invalidEmail
    case shortPassword
    case passwordMismatch
    case emailAlreadyExists
    case saveFailed
    
    var errorDescription: String? {
        switch self {
        case .emptyFields:
            return "모든 항목을 입력해주세요."
        case .invalidEmail:
            return "올바른 이메일 형식이 아닙니다."
        case .shortPassword:
            return "비밀번호는 8자 이상이어야 합니다."
        case .passwordMismatch:
            return "비밀번호가 일치하지 않습니다."
        case .emailAlreadyExists:
            return "이미 등록된 이메일입니다."
        case .saveFailed:
            return "회원가입에 실패했습니다."
        }
    }
}
