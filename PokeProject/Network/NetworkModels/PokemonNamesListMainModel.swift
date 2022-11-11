//
//  Welcome.swift
//  PokeProject
//
//  Created by User on 31.10.22.
//

import Foundation

struct PokemonNamesListMainModel: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonNamesListNetworkModel]
}

// MARK: - Result
struct PokemonNamesListNetworkModel: Codable {
    let name: String
    let url: String
}
