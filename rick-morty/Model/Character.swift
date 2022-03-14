//
//  Character.swift
//  rick-morty
//
//  Created by Teto on 1.03.2022.
//

import Foundation

// MARK: - Character
struct Character: Codable {
    let info: Info
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let location: Location
    let image: String
}

// MARK: - Location
struct Location: Codable {
    let name: String
}

// MARK: - Info
struct Info: Codable {
    let count: Int
    let next: String
}
