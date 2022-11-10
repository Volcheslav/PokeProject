//
//  TableNamesViewModel.swift
//  PokeProject
//
//  Created by User on 28.10.22.

import Foundation

class NamesListTableViewModel: NSObject, TableViewModelType {
    
    private var selectedIndexPath: IndexPath?
    let url = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=10"
    let offlineURLPlaceholder = "no connection"
    var nextURl: String?
    var prevURL: String?
    var names: [NamesListModel] = []
    var numberOfRows: Int {
        return names.count
    }
    
    // MARK: - Init
    
    override init() {
        super.init()
        self.fetchNames()
    }
    
    func cellViewModel(indexPath: IndexPath) -> TableViewCellViewModelType? {
        let name = names[indexPath.row]
        return NamesListTableViewCellViewModel(nameModel: name)
    }
    
    private func fetchNames() {
        initTableData(url: self.url)
    }
    
    private func initTableData(url: String) {
        let networkDataFetcher = NetworkDataFetcher()
        networkDataFetcher.fetchNamesList(urlString: url) { [weak self] (data) in
            guard let self = self, let data = data else { return }
            self.names = data.results.map { NamesListModel(name: $0.name, url: $0.url) }
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
    
    func viewModelForSelectedRow() -> DetailsViewModel? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return DetailsViewModel(url: names[selectedIndexPath.row].url, name: names[selectedIndexPath.row].name)
    }
    
    func selectRow(atIndexPath: IndexPath) {
        self.selectedIndexPath = atIndexPath
    }
    
    func getFromRealm() {
        let realm = RealmManager.shared.shareRealmData()
        self.names = realm.map { NamesListModel(name: $0.name, url: offlineURLPlaceholder) }
    }
}
