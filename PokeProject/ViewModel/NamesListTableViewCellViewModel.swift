//
//  NamesTableViewCellViewModel.swift
//  PokeProject
//
//  Created by User on 28.10.22.
//

import Foundation

class NamesListTableViewCellViewModel: TableViewCellViewModelTypeProtocol {
    
    // MARK: - View model
    
    private var nameModel: NamesListModel
    
    // MARK: - Variables
    
    var name: String {
        return nameModel.name
    }
    
    // MARK: - Init
    
    init(nameModel: NamesListModel) {
        self.nameModel = nameModel
    }
}
