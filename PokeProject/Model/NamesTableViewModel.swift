//
//  TableNamesViewModel.swift
//  PokeProject
//
//  Created by User on 28.10.22.
//

import Foundation

class NamesTableViewModel: NSObject, TableViewModelType {
    
    var networkDataFetcher = NetworkDataFetcher()
    let url = "https://pokeapi.co/api/v2/pokemon"
    var nextURl: String?
    var prevURL: String?
    
    var numberOfRows: Int {
        return names.count
    }
    
    func cellViewModel(indexPath: IndexPath) -> TableViewCellViewModelType? {
        let name = names[indexPath.row]
        return NamesTableViewCellViewModel(nameModel: name)
    }
    
    var names: [NamesModel] = []
        
    private func fetchNames() {
        initTableData(url: self.url)
    }
    
    func initTableData(url: String) {
        networkDataFetcher.dataFetcher(urlString: url) { [weak self] (data) in
            guard let self = self, let data = data else { return }
            self.names = data.results.map { NamesModel(name: $0.name, url: $0.url) }
            self.prevURL = data.previous
            self.nextURl = data.next
        }
    }
    
    func goRightPage() {
        guard let url = nextURl else { return }
        initTableData(url: url)
    }
    
    func goLeftPage() {
        guard let url = prevURL else { return }
        initTableData(url: url)
    }
    
    override init() {
        super.init()
        self.fetchNames()
    }

}
