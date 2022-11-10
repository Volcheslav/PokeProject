//
//  NamesTableViewCellViewModel.swift
//  PokeProject
//
//  Created by User on 28.10.22.
//

import Foundation

class NamesListTableViewCellViewModel: TableViewCellViewModelType {
    
    private var nameModel: NamesListModel
    
    var name: String {
        return nameModel.name
    }
    
    init(nameModel: NamesListModel) {
        self.nameModel = nameModel
    }
}
