//
//  DetailsViewModel.swift
//  PokeProject
//
//  Created by User on 2.11.22.
//

import Foundation

class DetailsViewModel {
    
    private var realmManager: RealmManagerProtocol?
    private var networkMonitor: NetworkMonitorProtocol?
    private var networkDataGeter: DataGeterProtocol?
    
    // MARK: - ViewModels
    
    private var details: DetailsModel?
    private var data: PokemonDetailsNetworkModel?
    
    // MARK: - Variables
    
    private var url: String?
    private var name: String?
    
    var errorMessage: String?
    
    // MARK: - Init function
    
    init(url: String?, name: String?, networkDataGeter: DataGeterProtocol?, realmManager: RealmManagerProtocol?, networkMonitor: NetworkMonitorProtocol?) {
        self.url = url
        self.name = name
        self.networkDataGeter = networkDataGeter
        self.realmManager = realmManager
        self.networkMonitor = networkMonitor
        self.getDetails()
        self.networkMonitor?.startMonitoring()
    }
    
    // MARK: Get network monitor state
    
    func checkIfIsConnected() -> Bool? {
        return networkMonitor?.isConnected
    }
    
    // MARK: Share details
    
    func returnDetails() -> DetailsModel? {
        guard let details = details else { return nil }
        return details
    }
    
    // MARK: - Details model load functions
    
    private func getDetails() {
        guard let url = url else { return }
        networkDataGeter?.fetchDetailsList(urlString: url) { [weak self] (data, errorMessage) in
            guard let self = self, let data = data else {
                self?.errorMessage = errorMessage
                return
            }
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
    
    // MARK: - Realm functions
    
    func getDataFromRealm() {
        guard let name = name,
              let realmModel = realmManager?.returnRealmData().filter({ $0.name == name.lowercased() }).first else { return }
        self.details = DetailsModel(
            height: realmModel.height,
            id: realmModel.id,
            name: realmModel.name,
            sprites: realmModel.sprites,
            types: realmModel.types,
            weight: realmModel.weight)
    }
    
    private func saveToRealm(details: DetailsModel) {
        let model = RealmPokeModel()
        model.id = details.id
        model.height = details.height
        model.sprites = details.sprites
        model.weight = details.weight
        model.name = details.name
        model.types = details.types
        realmManager?.saveUniq(id: details.id, model: model)
    }
}
