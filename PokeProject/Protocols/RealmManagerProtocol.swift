//
//  RealmManagerProtocol.swift
//  PokeProject
//
//  Created by User on 11.11.22.
//

import Foundation

protocol RealmManagerProtocol {
    func returnRealmData() -> [RealmPokeModel]
    func saveUniq(id: String, model: RealmPokeModel)
}
