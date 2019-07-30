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
    let id, userID, zipCode: Int
    let issueName, issueDescription, category: String
    let volunteer, completed, openForVoting: Bool
    let picture: JSONNull?
    
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

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    func hash(into hasher: inout Hasher) {
        var hashValue: Int {
            return 0
        }
    }
    
   
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
