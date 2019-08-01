//
//  User+Convenience.swift
//  Co-Make
//
//  Created by Kat Milton on 7/29/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import Foundation
import CoreData

extension User {
    
    @discardableResult convenience init(userID: Int, username: String? = nil, email: String, password: String, zipCode: Int, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        
        self.userID = Int32.init(userID)
        self.username = username
        self.email = email
        self.password = password
        self.zipCode = Int32.init(zipCode)
    }
    
    @discardableResult convenience init?(userRepresentation: UserRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        
        guard let id = userRepresentation.id else { return }
        
        self.userID = Int32(id)
        self.username = userRepresentation.username
        self.email = userRepresentation.email
        self.password = userRepresentation.password
        self.zipCode = zipCode
        
    }
    
    var userRepresentation: UserRepresentation? {
        guard let username = username,
            let email = email,
            let password = password else { return nil }
        
        return UserRepresentation(id: Int(userID), username: username, email: email, password: password, zipCode: Int(zipCode))
    }
    
}

