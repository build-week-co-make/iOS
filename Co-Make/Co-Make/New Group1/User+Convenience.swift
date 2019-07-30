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
    
    @discardableResult convenience init(username: String? = nil, email: String, password: String, zipCode: Int32, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        
        self.username = username
        self.email = email
        self.password = password
        self.zipCode = zipCode
    }
    
    @discardableResult convenience init?(userRepresentation: UserRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        
        self.username = userRepresentation.username
        self.email = userRepresentation.email
        self.password = userRepresentation.password
        self.zipCode = zipCode
        
    }
    
    var userRepresentation: UserRepresentation? {
        guard let username = username,
            let email = email,
            let password = password else { return nil }
        
        return UserRepresentation(username: username, email: email, password: password, zipCode: zipCode)
    }
    
}

