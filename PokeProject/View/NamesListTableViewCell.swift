//
//  TableNamesViewCell.swift
//  PokeProject
//
//  Created by User on 28.10.22.
//

import UIKit

class NamesListTableViewCell: UITableViewCell {
    
    // MARK: - View models
    
    weak var viewModel: NamesListTableViewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            nameLabel.text = viewModel.name
            nameLabel.textColor = .red
            nameLabel.textAlignment = .center
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet private weak var nameLabel: UILabel!
}
