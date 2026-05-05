//
//  UserRegistrationResponse.swift
//  ApiWithCodeCat
//
//  Created by Aakash Thakur on 26/03/26.
//

import Foundation

struct UserRegistrationResponse: Decodable {
    let errorMessage: String?
    let data: UserData?
}
struct UserData: Decodable {
    let name, email , id, joining: String
}
