//
//  TableViewModelType.swift
//  PokeProject
//
//  Created by User on 28.10.22.
//

import Foundation

protocol TableViewModelTypeProtocol {
    var numberOfRows: Int { get }
   // var networkDataGeter: DataGeterProtocol? { get set }
    func cellViewModel(indexPath: IndexPath) -> TableViewCellViewModelTypeProtocol?
    
    func viewModelForSelectedRow() -> DetailsViewModel?
    func selectRow(atIndexPath: IndexPath)
}
