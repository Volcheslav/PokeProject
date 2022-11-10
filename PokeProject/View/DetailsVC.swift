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
    
    var detailsViewModel: DetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkMonitor.shared.startMonitoring()
        setLoadingLabels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if NetworkMonitor.shared.isConnected != true {
            detailsViewModel?.getDataFromRealm()
        }
        setLabeles()
    }
    
    private func setLabeles() {
        guard let detailsVM = detailsViewModel, let details = detailsVM.details else { return }
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
