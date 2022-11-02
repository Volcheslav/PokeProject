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
            self.heightLabel.text = "Height: \(details.height) cm"
            self.weightLabel.text = "Weight: \(details.weight) g"
            self.typesLabel.text = "Types: \(details.types)"
            self.pokeImage.loadFrom(URLAddress: details.sprites)
        }
    }
}
