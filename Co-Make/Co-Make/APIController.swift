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
    
    var bearer: Bearer?
    var issues: [Issue] = []
    
    
    
    private let baseURL = URL(string: "https://co-make.herokuapp.com")!
    
    // MARK: - User data functions
    
    // MARK: - Creating user data
    
    // Call in Allow Location
    func signUp(with user: User, completion: @escaping (UserRepresentation?, Error?) -> Void = { _,_  in }) {
        let signUpUrl = baseURL.appendingPathComponent("auth/register")
        
        var request = URLRequest(url: signUpUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        guard let representation = user.userRepresentation else { completion(nil, NSError()); return }
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(representation)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user object: \(error)")
            completion(nil, error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(nil, NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            // Data Decode
            
            guard let data = data else { return }
            do {
                
                let jsonDecoder = JSONDecoder()
                let results = try jsonDecoder.decode(UserRepresentation.self, from: data)
                
                // Use function to add user to core data
                self.createUser(userID: results.userID, username: results.username!, email: results.email, password: results.password, zipCode: results.zipCode)
                
                
                completion(results, nil)
            }
            
            catch {
                NSLog("Error decoding user: \(error)")
                completion(nil, error)
                return
            }
            
            completion(nil, error)
            
            }.resume()
        
        // createuser
    }
    
   
    
    func createUser(userID: Int, username: String, email: String, password: String, zipCode: Int) {
        let user = User(userID: userID, username: username, email: email, password: password, zipCode: zipCode)
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving context: \(error)")
        }
        
        guard let email = user.email,
            let password = user.password else { return }
        
        signIn(with: email, password: password)
    }
    
    // MARK: - Signing in with user data
    
    func signIn(with email: String, password: String, completion: @escaping (Error?) -> Void = { _ in }) {
        guard let bearer = bearer else { return }
        let signInURL = baseURL.appendingPathComponent("auth/login")
        
        let userParameters: [String : String ] = [
            "email" : email,
            "password" : password
        ]
        
        var request = URLRequest(url: signInURL)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
       
        
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
    
    // MARK: - Editing user data
    
    private func update(user: User, with representation: UserRepresentation) {
        user.username = representation.username
        user.email = representation.email
        user.password = representation.password
        user.zipCode = Int32(representation.zipCode)
        user.userID = Int32(representation.userID)
    }
    
    // Call on profile page
    func updateUserInfo(with user: User, context: NSManagedObjectContext, completion: @escaping(Result<User, NetworkError>) -> Void = { _ in }) {
        guard let bearer = bearer else {
            completion(.failure(.noAuth))
            return
        }

        guard let email = user.email,
            let password = user.password else { return }

        let userDataURL = baseURL.appendingPathComponent("users/\(Int(user.userID))")
        var request = URLRequest(url: userDataURL)
        request.httpMethod = "PUT"
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")

        context.performAndWait {
            

        do {
            guard var representation = user.userRepresentation else { return }

            representation.email = email
            representation.password = password
            do {
                try CoreDataStack.shared.save()
            } catch {
                NSLog("Error saving context: \(error)")
            }
            request.httpBody = try JSONEncoder().encode(representation)
            self.update(user: user, with: representation)
        } catch {
            NSLog("Error encoding user \(user): \(error)")
            completion(.failure(.otherError))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                NSLog("Error putting new user data to server: \(error)")
                completion(.failure(.otherError))
                return
            }

            } .resume()
        }
    }
    
    // fetch user from core data
    private func singleUser(for userID: Int, context: NSManagedObjectContext) -> User? {
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
//        let predicate = NSPredicate(format: "identifier == %@", uuid as NSUUID)
        
//        fetchRequest.predicate = predicate
        
        var result: User? = nil
        
        context.performAndWait {
            
            do {
                let user = try context.fetch(fetchRequest).first
                
                result = user
            } catch {
                NSLog("Error fetching user with id: \(userID): \(error)")
            }
        }
        return result
    }
    
    
    // MARK: - Issue data functions
    
    
    // call in view did load of feed view
    func fetchIssuesFromServer(completion: @escaping (Error?) -> Void = { _ in }) {
        let requestURL = baseURL.appendingPathComponent("issues")
        
        
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching tasks: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(error)
                return }
            
            do {
                let issues = Array(try JSONDecoder().decode([String : Issue].self, from: data).values)
                self.issues = issues
                completion(nil)
            } catch {
                NSLog("Error decoding issues: \(error)")
                completion(nil)
                return
            }
            }.resume()
    }
    
    
    func putIssueOnServer(issue: Issue, completion: @escaping (Error?) -> Void = { _ in }) {
        let userID = issue.userID
        let requestURL = baseURL.appendingPathComponent("issues")
        let issueParameters: [String : Any ] = [
            "user_id" : issue.userID,
            "zipCode" : issue.zipCode,
            "issue_name" : issue.issueName,
            "description" : issue.issueDescription,
            "category" : issue.category
        ]
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONEncoder().encode(issueParameters)
        } catch {
            NSLog("Error ecoding issue: \(issue) \(error)")
            completion(error)
            return
        }
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error posting issue to the server")
                completion(error)
                return
                
                guard let data = data else { return }
                
                
//                completion(nil, error)
                
            }
            completion(nil)
            }.resume()
        
        
        
    }
    
    // call on create issue page
    func createIssue(id: Int, userID: Int, zipCode: Int, issueName: String, description: String, category: String, volunteer: Bool = false, completed: Bool = false, openForVoting: Bool = true, picture: String? = nil) {
        
       let issue = Issue(id: id, userID: userID, zipCode: zipCode, issueName: issueName, issueDescription: description, category: category, volunteer: volunteer, completed: completed, openForVoting: openForVoting, picture: picture)
        
        putIssueOnServer(issue: issue)
        
        }
    
    // call when commenting on issue
    func commentOnIssue(issueID: Int, userID: Int, comment: String, completion: @escaping (Error?) -> Void = { _ in }) {
        guard let bearer = bearer else { return }
        let requestURL = baseURL.appendingPathComponent("comments")
        
        let commentParameters: [String : Any ] = [
            "issue_id" : issueID,
            "user_id" : userID,
            "comment" : comment
        ]
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(commentParameters)
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
        
        
    // Call when selecting table view cell on feed
    func fetchSingleIssueWithComments(id: Int, completion: @escaping (Error?) -> Void = { _ in }) {
        let requestURL = baseURL.appendingPathComponent("issues")
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching tasks: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(error)
                return }
            
            do {
                let issues = Array(try JSONDecoder().decode([Issue : Any].self, from: data).values)
                completion(nil)
            } catch {
                NSLog("Error decoding issues: \(error)")
                completion(nil)
                return
            }
            }.resume()
    }

    
}
