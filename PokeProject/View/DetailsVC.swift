//
//  DetailsVC.swift
//  PokeProject
//
//  Created by User on 2.11.22.
//

import UIKit

final class DetailsVC: UIViewController {

    @IBOutlet private weak var nameLabel: UILabel!
    
    @IBOutlet private weak var pokeImage: UIImageView!
    
    @IBOutlet private weak var typesLabel: UILabel!
    
    @IBOutlet private weak var weightLabel: UILabel!
    
    @IBOutlet private weak var heightLabel: UILabel!
    
    @IBOutlet private weak var backButton: UIButton!
    
    @IBAction private func goBack(_ sender: UIButton) {
    }
    
    var detailsViewModel: DetailsViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.nameLabel.text = self.detailsViewModel?.details?.name
                //self.typesLabel.text = self.detailsViewModel?.details?.types
                self.weightLabel.text = String(self.detailsViewModel?.details?.weight ?? 0)
                self.heightLabel.text = String(self.detailsViewModel?.details?.height ?? 0)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsViewModel = DetailsViewModel()

    }
}
