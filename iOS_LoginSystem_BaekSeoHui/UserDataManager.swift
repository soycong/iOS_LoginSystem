//
//  UserDataManager.swift
//  iOS_LoginSystem_BaekSeoHui
//
//  Created by seohuibaek on 3/16/25.
//

import CoreData
import UIKit

final class UserDataManager {
    var container: NSPersistentContainer!
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
    }
    
    func createData(email: String, password: String, nickname: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: User.className, in: self.container.viewContext) else { return }
        
        let newUser = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        newUser.setValue(email, forKey: User.Key.email)
        newUser.setValue(password, forKey: User.Key.password)
        newUser.setValue(nickname, forKey: User.Key.nickname)
        
        do {
            try self.container.viewContext.save()
            print("유저 데이터 저장 성공")
        } catch {
            print("유저 데이터 저장 실패")
        }
    }
    
    // 데이터 읽기
    func readUserData(email: String) -> User? {
        let fetchRequest = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        fetchRequest.fetchLimit = 1

        do {
            let result = try self.container.viewContext.fetch(fetchRequest)
            
            return result.first
            
        } catch {
            print("유저 데이터 읽기 실패: \(error)")
            
            return nil
        }
    }
    
    // 전체 데이터 읽기
    func readAllUsers() -> [User] {
        let fetchRequest = User.fetchRequest()

        do {
            let result = try self.container.viewContext.fetch(fetchRequest)
            return result
        } catch {
            print("모든 유저 데이터 읽기 실패: \(error)")
            return []
        }
    }
    
    // 데이터 단일 삭제
    func deleteData(email: String) {
        let fetchRequest = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let result = try self.container.viewContext.fetch(fetchRequest)
            
            for data in result as [NSManagedObject] {
                self.container.viewContext.delete(data)
                print("삭제된 유저 데이터: \(data)")
            }
            
            try self.container.viewContext.save()
            print("유저 데이터 삭제 완료")
            
        } catch {
            print("데이터 삭제 실패: \(error)")
        }
    }
}
