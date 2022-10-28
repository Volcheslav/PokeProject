//
//  TableNamesViewModel.swift
//  PokeProject
//
//  Created by User on 28.10.22.
//

import Foundation

class NamesTableViewModel: TableViewModelType {
    
    var numberOfRows: Int {
        return names.count
    }
    
    func cellViewModel(indexPath: IndexPath) -> TableViewCellViewModelType? {
        let name = names[indexPath.row]
        return NamesTableViewCellViewModel(nameModel: name)
    }
    
    var names = [
    NamesModel(name: "Max"),
    NamesModel(name: "Ivan"),
    NamesModel(name: "Dimon"),
    NamesModel(name: "Vlad")]
    
}
