//
//  DetailsViewModel.swift
//  PokeProject
//
//  Created by User on 2.11.22.
//

import Foundation

class DetailsViewModel {
    
    var details: DetailsModel?
    
    var data: DetailsNetworkModel?
    
    var url: String?
    var name: String?
    
    private var networkDataFetcher = NetworkDataFetcher()
    
    private func getDetails() {
        guard let url = url else { return }
        networkDataFetcher.fetchDetailsList(urlString: url) { [weak self] (data) in
            guard let self = self, let data = data else { return }
            self.data = data
            self.setDetails()
        }
    }
    private func setDetails() {
        guard let data = self.data else { return }
        let sprite = data.sprites.frontDefault != nil ? data.sprites.frontDefault! : "no data"
        self.details = DetailsModel(
            height: String(data.height),
            id: String(data.id),
            name: data.name,
            sprites: sprite,
            types: data.types.map { $0.type.name }.joined(separator: ", "),
            weight: String(data.weight))
        DispatchQueue.main.async {
            self.saveToRealm(details: self.details!)
        }
    }
    
    private func saveToRealm(details: DetailsModel) {
        let model = RealmPokeModel()
        model.id = details.id
        model.height = details.height
        model.sprites = details.sprites
        model.weight = details.weight
        model.name = details.name
        model.types = details.types
        RealmManager.shared.saveUniq(id: details.id, model: model)
    }
    
    func getDataFromRealm() {
        guard let name = name,
              let realmModel = RealmManager.shared.shareRealmData().filter({ $0.name == name }).first else { return }
        self.details = DetailsModel(
            height: realmModel.height,
            id: realmModel.id,
            name: realmModel.name,
            sprites: realmModel.sprites,
            types: realmModel.types,
            weight: realmModel.weight)
        
    }
    
    init(url: String, name: String) {
        self.url = url
        self.name = name
        self.getDetails()
    }
}
