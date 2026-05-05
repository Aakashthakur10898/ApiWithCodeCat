//
//  UserRegistrationRequest.swift
//  ApiWithCodeCat
//
//  Created by ucodesoft on 25/03/26.
//

import Foundation

//We use Encodable to Post data to server
struct UserRegistrationRequest: Encodable {
    let FirstName: String
    let LastName: String
    let Email: String
    let Password: String
    
    enum CodingKeys: String, CodingKey {
        case FirstName = "First_Name" //Name that we want pass as a key in request params
        case LastName = "Last_Name"
        
        case Email, Password
    }
}
