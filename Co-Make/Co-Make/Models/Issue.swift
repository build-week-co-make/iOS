//
//  Issue.swift
//  Co-Make
//
//  Created by Kat Milton on 7/30/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import Foundation

// MARK: - Issue
struct Issue: Codable {
    var id, userID, zipCode: Int
    let issueName, issueDescription, category: String
    let volunteer, completed, openForVoting: Bool
    let picture: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case zipCode
        case issueName = "issue_name"
        case issueDescription = "description"
        case category, volunteer, completed
        case openForVoting = "open_for_voting"
        case picture
    }
}


