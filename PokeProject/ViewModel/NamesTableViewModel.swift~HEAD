//
//  TableNamesViewModel.swift
//  PokeProject
//
//  Created by User on 28.10.22.
// swiftlint:disable force_try

import Foundation
import RealmSwift

class NamesTableViewModel: TableViewModelType {
    
    var networkDataFetcher = NetworkDataFetcher()
    let url = "https://pokeapi.co/api/v2/pokemon"
    
    var numberOfRows: Int {
        return names.count
    }
    
    let realm = try! Realm()
    var items: Results<MainRealmModel>!
    
    func addToRealm(name: String, url: String) {
        let realmModel = MainRealmModel()
        realmModel.name = name
        realmModel.url = url
        try! realm.write {
            realm.add(realmModel)
        }
        print("added")
    }
    
    func checkRealm(name: String) -> Bool {
        let items = realm.objects(MainRealmModel.self)
        return items.filter { $0.name == name }.isEmpty
        
    }
    
    func cellViewModel(indexPath: IndexPath) -> TableViewCellViewModelType? {
        let name = names[indexPath.row]
        return NamesTableViewCellViewModel(nameModel: name)
    }
    
    var names: [NamesModel] = []
            
    private func updateNames() {
        items = realm.objects(MainRealmModel.self)
        networkDataFetcher.dataFetcher(urlString: url) { [weak self] (data) in
            guard let self = self, let data = data else { return }
            self.names = data.results.map { NamesModel(name: $0.name, url: $0.url)
            }
            data.results.forEach {
                if self.checkRealm(name: $0.name) {
                    self.addToRealm(name: $0.name, url: $0.url)
                    
                }
                }
            }
    }
    
    init() {
        self.updateNames()
    }

}
