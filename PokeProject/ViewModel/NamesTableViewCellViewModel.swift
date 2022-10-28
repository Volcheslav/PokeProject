//
//  NamesTableViewCellViewModel.swift
//  PokeProject
//
//  Created by User on 28.10.22.
//

import Foundation

class NamesTableViewCellViewModel: TableViewCellViewModelType {
    
    private var nameModel: NamesModel
    
    var name: String {
        return nameModel.name
    }
    
    init(nameModel: NamesModel) {
        self.nameModel = nameModel
    }
}
