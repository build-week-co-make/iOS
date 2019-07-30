//
//  APIController.swift
//  Co-Make
//
//  Created by Luqmaan Khan on 7/28/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import Foundation
import CoreData

class ApiController {
    
    enum NetworkError: Error {
        case noAuth
        case badAuth
        case otherError
        case badData
        case noDecode
        
    }
    
    var user: User?
    var bearer: Bearer?
    var userAuthentication: UserAuthentication?
    
    private let baseURL = URL(string: "https://co-make.herokuapp.com")!
    
    // MARK: - User data functions
    
    func signUp(with user: User, completion: @escaping (Error?) -> Void = { _ in }) {
        let signUpUrl = baseURL.appendingPathComponent("auth/register")
        
        var request = URLRequest(url: signUpUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        guard let representation = user.userRepresentation else { completion(NSError()); return }
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(representation)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user object: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
            
            }.resume()
    }
    
    
    func createUser(username: String, email: String, password: String, zipCode: Int32) {
        let user = User(username: username, email: email, password: password, zipCode: zipCode)
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving context: \(error)")
        }
        signUp(with: user)
    }
    
    
    func signIn(with email: String, password: String, completion: @escaping (Error?) -> Void = { _ in }) {
        let signInURL = baseURL.appendingPathComponent("auth/login")
        
        let userParameters: [String : String ] = [
            "email" : email,
            "password" : password
        ]
        
        var request = URLRequest(url: signInURL)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
        
        
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(userParameters)
             request.httpBody = jsonData
        } catch {
            print("Error encoding user object: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            print(String(data: data, encoding: .utf8) ?? "")
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                self.bearer = try decoder.decode(Bearer.self, from: data)
            } catch {
                completion(error)
                return
            }
            
            completion(nil)
            }.resume()
    }
    
    func editUser(user: User, username: String? = nil, email: String, password: String, zipCode: Int32) {
        
        user.username = username
        user.email = email
        user.password = password
        user.zipCode = zipCode
        
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving context: \(error)")
        }
        
        
        
    }
    
    private func updateUser(with representation: [UserRepresentation], context: NSManagedObjectContext) throws {
        
        var error: Error? = nil
        
        context.performAndWait {
            for userRep in representation {
               
                
            }
            
            do {
                try context.save()
            } catch let saveError {
                error = saveError
            }
        }
        
        if let error = error { throw error }
        
        
    }
    
    private func update(user: User, with representation: UserRepresentation) {
        user.username = representation.username
        user.email = representation.email
        user.password = representation.password
        user.zipCode = representation.zipCode
    }
    
    
    
    
//    func updateUserInfo(with user: User, completion: @escaping(Result<User, NetworkError>) -> Void = { _ in }) {
//        guard let bearer = bearer else {
//            completion(.failure(.noAuth))
//            return
//        }
//
//        guard let email = user.email,
//            let password = user.password else { return }
//
//        let userDataURL = baseURL.appendingPathComponent("users/1")
//        var request = URLRequest(url: userDataURL)
//        request.httpMethod = "PUT"
//        request.addValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
//
//
//        do {
//            guard var representation = user.userRepresentation else { return }
//
//            representation.email = email
//            representation.password = password
//            do {
//                try CoreDataStack.shared.save()
//            } catch {
//                NSLog("Error saving context: \(error)")
//            }
//            request.httpBody = try JSONEncoder().encode(representation)
//        } catch {
//            NSLog("Error encoding user \(user): \(error)")
//            completion(.failure(.otherError))
//            return
//        }
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//
//            if let error = error {
//                NSLog("Error putting new user data to server: \(error)")
//                completion(.failure(.otherError))
//                return
//            }
//
//            } .resume()
//    }
//
    
    
    
    // MARK: - Issue data functions
    
    func createIssue(userID: Int32, zipCode: Int32, issueName: String, description: String, category: String) {
        let issue = Issue(userID: userID, zipCode: zipCode, issueName: issueName, description: description, category: category)
        
        do {
        try CoreDataStack.shared.save()
        } catch {
        NSLog("Error saving context: \(error)")
        }
        
        }
    
    
}
