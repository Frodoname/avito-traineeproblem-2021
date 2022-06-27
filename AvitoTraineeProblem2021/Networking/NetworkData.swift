//
//  NetworkModel.swift
//  AvitoTraineeProblem2021
//
//  Created by Fed on 27.06.2022.
//

import Foundation


struct NetworkData: Codable {
    
    let company: Name
}

struct Name: Codable {
    let name: String
    let employees: [Employees]
}

struct Employees: Codable {
    
    let name: String
    let phone_number: String
    let skills: [String]
}


