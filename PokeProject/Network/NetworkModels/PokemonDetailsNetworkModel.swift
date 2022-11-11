//
//  DetailsNetworkModel.swift
//  PokeProject
//
//  Created by User on 2.11.22.
//

import Foundation

struct PokemonDetailsNetworkModel: Codable {
    let height: Int
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let weight: Int

    enum CodingKeys: String, CodingKey {
        case height
        case id
        case name
        case sprites ,types, weight
    }
}

struct Sprites: Codable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct TypeElement: Codable {
    let type: Species
}

struct Species: Codable {
    let name: String
    let url: String
}
