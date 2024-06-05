//
//  CoreDataService.swift
//  iosAssigment
//
//  Created by Macbook on 04/06/2024.
//

import Foundation
import CoreData
import UIKit
 
class CoredataController {
    static let shared = CoredataController()
    // MARK: - User
    func createUser(login: String,id: Int, avatarUrl: String, htmlUrl: String, completion: @escaping (Bool) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserCD")
        fetchRequest.predicate = NSPredicate(format: "login == %@", login)
        do {
            let existingUsers = try context.fetch(fetchRequest) as! [NSManagedObject]
            if existingUsers.isEmpty {
                let userEntity = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
                userEntity.setValue(login, forKey: "login")
                userEntity.setValue(id, forKey: "id")
                userEntity.setValue(avatarUrl, forKey: "avatarUrl")
                userEntity.setValue(htmlUrl, forKey: "htmlUrl")
                try context.save()
                print("User saved to Core Data")
                completion(true)
            } else {
                print("User already exists in Core Data")
                completion(false)
            }
        } catch {
            print("Error checking for existing user: \(error)")
            completion(false)
        }
    }
    func updateUser(login: String, id: Int, avatarUrl: String, htmlUrl: String, completion: @escaping (Bool) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserCD")
        fetchRequest.predicate = NSPredicate(format: "login == %@", login)
        do {
            let users = try context.fetch(fetchRequest) as? [NSManagedObject]
            if let userToUpdate = users?.first as? UserCD {
                userToUpdate.id = Int64(id)
                userToUpdate.avatarUrl = avatarUrl
                userToUpdate.htmlUrl = htmlUrl
                try context.save()
                print("User updated in Core Data")
                completion(true)
            } else {
                print("User not found in Core Data")
                completion(false)
            }
        } catch {
            print("Error updating user: \(error)")
            completion(false)
        }
    }
    func deleteUser(login: String, completion: @escaping (Bool) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserCD")
        fetchRequest.predicate = NSPredicate(format: "login == %@", login)
        do {
            let users = try context.fetch(fetchRequest) as? [NSManagedObject]
            if let userToDelete = users?.first {
                context.delete(userToDelete)
                try context.save()
                print("User deleted from Core Data")
                completion(true)
            } else {
                print("User not found in Core Data")
                completion(false)
            }
        } catch {
            print("Error deleting user: \(error)")
            completion(false)
        }
    }
    // MARK: - UserDetail
    func createUserDetail(bio: String, id: Int64, followers: Int, following: Int, location: String?, name: String?, publicRepos: Int, login: String, completion: @escaping (Bool) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserDetailCD")
        fetchRequest.predicate = NSPredicate(format: "login == %@", login)
        do {
            let users = try context.fetch(fetchRequest) as? [NSManagedObject]
            if let user = users?.first as? UserCD {
                print("User existing")
            } else {
                
                let userDetailEntity = NSEntityDescription.insertNewObject(forEntityName: "UserDetail", into: context)
                userDetailEntity.setValue(bio, forKey: "bio")
                userDetailEntity.setValue(id, forKey: "id")
                userDetailEntity.setValue(followers, forKey: "followers")
                userDetailEntity.setValue(following, forKey: "following")
                userDetailEntity.setValue(location, forKey: "location")
                userDetailEntity.setValue(name, forKey: "name")
                userDetailEntity.setValue(publicRepos, forKey: "publicRepos")
                userDetailEntity.setValue(login, forKey: "login")
                try context.save()
                print("UserDetail saved to Core Data")
                completion(true)
                completion(false)
            }
        } catch {
            print("Error checking for existing user: \(error)")
            completion(false)
        }
    }
    func updateUserDetail(bio: String, id: Int64, followers: Int, following: Int, location: String?, name: String?, publicRepos: Int, login: String, completion: @escaping (Bool) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserDetailDC")
        fetchRequest.predicate = NSPredicate(format: "user.login == %@", login)
        do {
            let userDetails = try context.fetch(fetchRequest) as? [NSManagedObject]
            if var userDetailToUpdate = userDetails?.first as? UserDetailCD {
                userDetailToUpdate.setValue(bio, forKey: "bio")
                userDetailToUpdate.setValue(id, forKey: "id")
                userDetailToUpdate.setValue(followers, forKey: "followers")
                userDetailToUpdate.setValue(following, forKey: "following")
                userDetailToUpdate.setValue(location, forKey: "location")
                userDetailToUpdate.setValue(name, forKey: "name")
                userDetailToUpdate.setValue(publicRepos, forKey: "publicRepos")
                userDetailToUpdate.setValue(login, forKey: "login")
                try context.save()
                print("UserDetail updated in Core Data")
                completion(true)
            } else {
                print("UserDetail not found in Core Data")
                completion(false)
            }
        } catch {
            print("Error updating userDetail: \(error)")
            completion(false)
        }
    }
    func deleteUserDetail(username: String, completion: @escaping (Bool) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserDetail")
        fetchRequest.predicate = NSPredicate(format: "user.username == %@", username)
        do {
            let userDetails = try context.fetch(fetchRequest) as? [NSManagedObject]
            if let userDetailToDelete = userDetails?.first {
                context.delete(userDetailToDelete)
                try context.save()
                print("UserDetail deleted from Core Data")
                completion(true)
            } else {
                print("UserDetail not found in Core Data")
                completion(false)
            }
        } catch {
            print("Error deleting userDetail: \(error)")
            completion(false)
        }
    }
}

