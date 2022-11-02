//
//  RealmManager.swift
//  PokeProject
//
//  Created by User on 2.11.22.
// swiftlint:disable force_try

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let realm = try! Realm()
    
    private func savePokeModel(model: RealmPokeModel) {
        
        try! self.realm.write {
            self.realm.add(model)
        }
    }
    
    func shareRealmData() -> [RealmPokeModel] {
        return Array(realm.objects(RealmPokeModel.self))
    }
    
    private func findInRealm(id: String) -> Bool {
        let pokeModels = realm.objects(RealmPokeModel.self)
        return pokeModels.filter { $0.id == id }.isEmpty
    }
    
    func saveUniq(id: String, model: RealmPokeModel) {
        if findInRealm(id: id) {
            savePokeModel(model: model)
        } else {
            return
        }
    }
    
}
