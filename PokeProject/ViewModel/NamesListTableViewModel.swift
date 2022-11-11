//
//  TableNamesViewModel.swift
//  PokeProject
//
//  Created by User on 28.10.22.

import Foundation

class NamesListTableViewModel: NSObject, TableViewModelType {
    
    // MARK: - Constants
    
    private let url = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=10"
    private let offlineURLPlaceholder = "no connection"
    
    // MARK: - Variables
    
    private var selectedIndexPath: IndexPath?
    private var nextURl: String?
    private var prevURL: String?
    private var names: [NamesListModel] = []
    
    var networkDataGeter: DataGeterProtocol?
    
    var numberOfRows: Int {
        return names.count
    }
    
    // MARK: - Init
    
    override init() {
        super.init()
        self.networkDataGeter = NetworkDataGeter(networkDataFetcher: NetworkDataFetcher(networkManager: NetworkManager()))
        self.fetchNames()
    }
    
    // MARK: - List change functions
    
    func goRightPage() {
        guard let url = nextURl else { return }
        initTableData(url: url)
    }
    
    func goLeftPage() {
        guard let url = prevURL else { return }
        initTableData(url: url)
    }
    
    // MARK: - View models return functions
    
    func viewModelForSelectedRow() -> DetailsViewModel? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return DetailsViewModel(
            url: names[selectedIndexPath.row].url,
            name: names[selectedIndexPath.row].name,
            networkDataGeter: NetworkDataGeter(networkDataFetcher: NetworkDataFetcher(networkManager: NetworkManager())))
    }
    
    func cellViewModel(indexPath: IndexPath) -> TableViewCellViewModelType? {
        let name = names[indexPath.row]
        return NamesListTableViewCellViewModel(nameModel: name)
    }
    
    // MARK: - Realm functions
    
    func getFromRealm() {
        let realm = RealmManager.shared.shareRealmData()
        self.names = realm.map { NamesListModel(name: $0.name, url: offlineURLPlaceholder) }
    }
    
    // MARK: - Table functions
    
    func selectRow(atIndexPath: IndexPath) {
        self.selectedIndexPath = atIndexPath
    }
    
    private func initTableData(url: String) {
        guard let networkDataGeter = networkDataGeter else { return }
        networkDataGeter.fetchNamesList(urlString: url) { [weak self] (data) in
            guard let self = self, let data = data else { return }
            self.names = data.results.map { NamesListModel(name: $0.name, url: $0.url) }
            self.prevURL = data.previous
            self.nextURl = data.next
        }
    }
    
    private func fetchNames() {
        initTableData(url: self.url)
    }
}
