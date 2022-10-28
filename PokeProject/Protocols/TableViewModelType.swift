//
//  TableViewModelType.swift
//  PokeProject
//
//  Created by User on 28.10.22.
//

import Foundation

protocol TableViewModelType {
    var numberOfRows: Int { get }
    func cellViewModel(indexPath: IndexPath) -> TableViewCellViewModelType?
}
