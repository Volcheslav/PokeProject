//
//  DetailsVC.swift
//  PokeProject
//
//  Created by User on 2.11.22.
//

import UIKit

final class DetailsVC: UIViewController {
    
    // MARK: - ViewModels
    
    var detailsViewModel: DetailsViewModel?

    // MARK: - Outlets
    // MARK: Interface elements
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var pokeImage: UIImageView!
    @IBOutlet private weak var typesLabel: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var heightLabel: UILabel!
    @IBOutlet private weak var backButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction private func goBack(_ sender: UIButton) {
        backButton.animateButton()
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoadingLabels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if detailsViewModel?.checkIfIsConnected() != true {
            detailsViewModel?.getDataFromRealm()
        }
        if detailsViewModel?.errorMessage != nil {
            self.showAlertWithCancelButn(title: ("NETWORK_ERR_TITLE")§, message: (detailsViewModel?.errorMessage)!)
        }
        setLabeles()
    }
    
    // MARK: - Set interface functions
    
    private func setLabeles() {
        guard let detailsVM = detailsViewModel, let details = detailsVM.returnDetails() else { return }
        DispatchQueue.main.async {
            self.nameLabel.text = "\(details.name.capitalized)"
            self.heightLabel.text = "\(("HEIGHT")§) \(details.height) \(("CM")§)"
            self.weightLabel.text = "\(("WEIGHT")§) \(details.weight) \(("GR")§)"
            self.typesLabel.text = "\(("TYPES")§) \(details.types)"
            self.pokeImage.loadFrom(URLAddress: details.sprites)
        }
    }
    
    private func setLoadingLabels() {
        nameLabel.text = ("LOADING")§
        typesLabel.text = "\(("TYPES")§) \(("LOADING")§)"
        weightLabel.text = "\(("WEIGHT")§) \(("LOADING")§)"
        heightLabel.text = "\(("HEIGHT")§) \(("LOADING")§)"
        backButton.setTitle(("BACK")§, for: .normal)
    }
}
