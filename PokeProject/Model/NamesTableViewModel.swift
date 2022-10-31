//
//  TableNamesViewModel.swift
//  PokeProject
//
//  Created by User on 28.10.22.
//

import Foundation

class NamesTableViewModel: TableViewModelType {
    
    var networkDataFetcher = NetworkDataFetcher()
    let url = "https://pokeapi.co/api/v2/pokemon"
    
    var numberOfRows: Int {
        return names.count
    }
    
    func cellViewModel(indexPath: IndexPath) -> TableViewCellViewModelType? {
        let name = names[indexPath.row]
        return NamesTableViewCellViewModel(nameModel: name)
    }
    
//    var names = [
//    NamesModel(name: "Max"),
//    NamesModel(name: "Ivan"),
//    NamesModel(name: "Dimon"),
//    NamesModel(name: "Vlad")]
    
    var names: [NamesModel] = []
        
//    private func getNamesData() -> [NamesModel] {
//        var names: [NamesModel] = []
//        networkDataFetcher.dataFetcher(urlString: url) {(data) in
//            names = data?.results.map { NamesModel(name: $0.name) } ?? []
//        }
//        return names
//    }
    
    private func updateNames() {
        print("start updating")
        networkDataFetcher.dataFetcher(urlString: url) { [weak self] (data) in
            guard let self = self, let data = data else { return }
            self.names = data.results.map { NamesModel(name: $0.name) }
            print("updated")
            print(self.numberOfRows)
            print(self.names)
        }
    }
    
    init() {
        self.updateNames()
    }

}
