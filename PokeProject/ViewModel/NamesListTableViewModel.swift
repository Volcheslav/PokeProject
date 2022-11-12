//
//  TableNamesViewModel.swift
//  PokeProject
//
//  Created by User on 28.10.22.

import Foundation

class NamesListTableViewModel: NSObject, TableViewModelTypeProtocol {
    
    var networkDataGeter: DataGeterProtocol?
    var realmManager: RealmManagerProtocol?
    
    // MARK: - Constants
    
    private let url = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=10"
    private let offlineURLPlaceholder = "no connection"
    
    // MARK: - Variables
    
    private var selectedIndexPath: IndexPath?
    private var nextURl: String?
    private var prevURL: String?
    private var names: [NamesListModel] = []
    
    var errorMessage: String?
    var numberOfRows: Int {
        return names.count
    }
    
    // MARK: - Init
    
    init(networkDataGeter: DataGeterProtocol, realmManager: RealmManagerProtocol ) {
        self.networkDataGeter = networkDataGeter
        self.realmManager = realmManager
    }
    
    override init() {
        super.init()
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
            networkDataGeter: NetworkDataGeter(networkDataFetcher: NetworkDataFetcher(networkManager: NetworkManager())),
            realmManager: RealmManager())
    }
    
    func cellViewModel(indexPath: IndexPath) -> TableViewCellViewModelTypeProtocol? {
        let name = names[indexPath.row]
        return NamesListTableViewCellViewModel(nameModel: name)
    }
    
    // MARK: - Realm functions
    
    func getFromRealm() {
        guard let realmManager = realmManager else { return }
        let realm = realmManager.shareRealmData()
        self.names = realm.map { NamesListModel(name: $0.name, url: offlineURLPlaceholder) }
    }
    
    // MARK: - Table functions
    
    func selectRow(atIndexPath: IndexPath) {
        self.selectedIndexPath = atIndexPath
    }
    
    private func initTableData(url: String) {
        guard let networkDataGeter = networkDataGeter else { return }
        networkDataGeter.fetchNamesList(urlString: url) { [weak self] (data, errorMessage) in
            guard let self = self, let data = data else {
                self?.errorMessage = errorMessage
                return
            }
            self.names = data.results.map { NamesListModel(name: $0.name, url: $0.url) }
            self.prevURL = data.previous
            self.nextURl = data.next
        }
    }
    
   func fetchNames() {
        initTableData(url: self.url)
    }
}
