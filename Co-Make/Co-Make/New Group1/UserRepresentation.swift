//
//  User.swift
//  Co-Make
//
//  Created by Luqmaan Khan on 7/28/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import Foundation

struct UserRepresentation: Equatable, Codable {

    var name: String
    var email: String
    var password: String
    var zipCode: String
}


struct UserRepresentations: Codable {
    let results: [UserRepresentation]
}

func == (lhs: UserRepresentation, rhs: User) -> Bool {
    return lhs.email == rhs.email && lhs.password == rhs.password
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
