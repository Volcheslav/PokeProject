//
//  Welcome.swift
//  PokeProject
//
//  Created by User on 31.10.22.
//

import Foundation

struct NamesListMainModel: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [NamesListNetworkModel]
}

// MARK: - Result
struct NamesListNetworkModel: Codable {
    let name: String
    let url: String
}
