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
    
    @discardableResult convenience init(name: String, email: String, password: String, zipCode: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        
        self.name = name
        self.email = email
        self.password = password
        self.zipCode = zipCode
    }
    
    @discardableResult convenience init?(userRepresentation: UserRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(context: context)
        
        self.name = userRepresentation.name
        self.email = userRepresentation.email
        self.password = userRepresentation.password
        self.zipCode = zipCode
        
    }
    
    var userRepresentation: UserRepresentation? {
        guard let name = name,
            let email = email,
            let password = password,
            let zipCode = zipCode else { return nil }
        
        return UserRepresentation(name: name, email: email, password: password, zipCode: zipCode)
    }
    
}

