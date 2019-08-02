//
//  User.swift
//  Co-Make
//
//  Created by Luqmaan Khan on 7/28/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import Foundation

struct UserRepresentation: Equatable, Codable {

    var id: Int? = nil
    var username: String? = nil
    var email: String
    var password: String
    var zipCode: Int
    
}


struct UserRepresentations: Codable {
    let results: [UserRepresentation]
}

func == (lhs: UserRepresentation, rhs: User) -> Bool {
    return lhs.email == rhs.email && lhs.email == rhs.email
}

func == (lhs: User, rhs: UserRepresentation) -> Bool {
    return rhs == lhs
}

func != (lhs: UserRepresentation, rhs: User) -> Bool {
    return !(rhs == lhs)
}

func != (lhs: User, rhs: UserRepresentation) -> Bool {
    return rhs != lhs
}
