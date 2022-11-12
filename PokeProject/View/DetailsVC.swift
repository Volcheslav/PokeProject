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
    
    // MARK: - Strings enum
    
    private enum DetailsVCStrings: String {
        case heightText = "HEIGHT"
        case segueID = "detailsSegue"
        case loading = "LOADING"
        case backButton = "BACK"
        case nextButton = "NEXT_PAGE"
        case typesText = "TYPES"
        case weightText = "WEIGHT"
        case cm = "CM"
        case gr = "GR"
        case networkErrorAlertTitle = "NETWORK_ERR_TITLE"
    }

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
        if detailsViewModel?.returnConnectionState() != true {
            detailsViewModel?.getDataFromRealm()
        }
        if detailsViewModel?.errorMessage != nil {
            self.showAlertWithCancelButn(title: (DetailsVCStrings.networkErrorAlertTitle.rawValue)§, message: (detailsViewModel?.errorMessage)!)
        }
        setLabeles()
    }
    
    // MARK: - Set interface functions
    
    private func setLabeles() {
        guard let detailsVM = detailsViewModel, let details = detailsVM.shareDetails() else { return }
        DispatchQueue.main.async {
            self.nameLabel.text = "\(details.name.capitalized)"
            self.heightLabel.text = "\((DetailsVCStrings.heightText.rawValue)§) \(details.height) \((DetailsVCStrings.cm.rawValue)§)"
            self.weightLabel.text = "\((DetailsVCStrings.weightText.rawValue)§) \(details.weight) \((DetailsVCStrings.gr.rawValue)§)"
            self.typesLabel.text = "\((DetailsVCStrings.typesText.rawValue)§) \(details.types)"
            self.pokeImage.loadFrom(URLAddress: details.sprites)
        }
    }
    
    private func setLoadingLabels() {
        nameLabel.text = (DetailsVCStrings.loading.rawValue)§
        typesLabel.text = "\((DetailsVCStrings.typesText.rawValue)§) \((DetailsVCStrings.loading.rawValue)§)"
        weightLabel.text = "\((DetailsVCStrings.weightText.rawValue)§) \((DetailsVCStrings.loading.rawValue)§)"
        heightLabel.text = "\((DetailsVCStrings.heightText.rawValue)§) \((DetailsVCStrings.loading.rawValue)§)"
        backButton.setTitle((DetailsVCStrings.backButton.rawValue)§, for: .normal)
    }
}
