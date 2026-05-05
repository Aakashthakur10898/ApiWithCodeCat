//
//  EmployeeResponse.swift
//  ApiWithCodeCat
//
//  Created by Aakash Thakur on 26/03/26.
//

import Foundation

struct EmployeeResponse: Decodable {
    let id, depid: Int
    let salary: Double
    let name, role, joining, workPhone: String
}
