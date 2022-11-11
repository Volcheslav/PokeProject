//
//  RealmManager.swift
//  PokeProject
//
//  Created by User on 2.11.22.
// swiftlint:disable force_try

import Foundation
import RealmSwift

class RealmManager: RealmManagerProtocol {
    
    let realm = try! Realm()
    
    // MARK: - Share and save public
    
    func shareRealmData() -> [RealmPokeModel] {
        return Array(realm.objects(RealmPokeModel.self))
    }
    
    func saveUniq(id: String, model: RealmPokeModel) {
        if findInRealm(id: id) {
            savePokeModel(model: model)
        } else {
            return
        }
    }
    
    // MARK: - Save and find functions
    
    private func savePokeModel(model: RealmPokeModel) {
        
        try! self.realm.write {
            self.realm.add(model)
        }
    }
    
    private func findInRealm(id: String) -> Bool {
        let pokeModels = realm.objects(RealmPokeModel.self)
        return pokeModels.filter { $0.id == id }.isEmpty
    }
}
