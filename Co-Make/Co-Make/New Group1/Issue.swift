//
//  Issue.swift
//  Co-Make
//
//  Created by Kat Milton on 7/30/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import Foundation

struct Issue: Codable {
    
    var userID: userID
    var zipCode: Int
    var issueName: issueName
    var description: String
    var category: String
    
    
    
    struct userID: Codable {
        let user_id: Int
    }
    
    struct issueName: Codable {
        let issue_name: String
        
    }
    
}
