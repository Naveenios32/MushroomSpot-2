//
//  LoginResponse.swift
//  MushroomSpot
//
//  Created by Apple on 14/04/25.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let email: String
}

struct LoginResponse: Codable {
    let token: String
    let user: User
}
