//
//  Comment.swift
//  Co-Make
//
//  Created by Kat Milton on 7/31/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import Foundation

struct Comment: Encodable {
    let issueID: Int
    let userID: Int
    let comment: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case comment
    }
    
    func encode(to encoder: Encoder) throws {
        // 2
        var container = encoder.container(keyedBy: CodingKeys.self)
        // 3
        try container.encode(issueID, forKey: .id)
        try container.encode(userID, forKey: .userID)
        // 4
        try container.encode(comment, forKey: .comment)
    }
}
