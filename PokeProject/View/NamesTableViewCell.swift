//
//  TableNamesViewCell.swift
//  PokeProject
//
//  Created by User on 28.10.22.
//

import UIKit

class NamesTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    weak var viewModel: NamesTableViewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
        
            nameLabel.text = viewModel.name
            nameLabel.textColor = .red
            nameLabel.textAlignment = .center
        }
    }
}
