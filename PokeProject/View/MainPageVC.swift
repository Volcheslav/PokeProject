//
//  MainPageVC.swift
//  PokeProject
//
//  Created by User on 28.10.22.
//

import UIKit

final class MainPageVC: UIViewController {
    
    private let cellID  = "nameCell"
    
    var viewModel: MainPageViewModel? {
        didSet {
            guard let text = viewModel?.text else { return }
            self.warningLabel.text = text
        }
    }
    
    @IBOutlet private weak var warningLabel: UILabel!
    
    @IBAction private func leftSwipeUpdate(_ sender: UISwipeGestureRecognizer) {
        tableViewModel.goLeftPage()
        DispatchQueue.main.async {
            self.namesTableView.reloadData()
        }
        
    }
    @IBAction private func rightSwipeUpdate(_ sender: UISwipeGestureRecognizer) {
        tableViewModel.goRightPage()
        DispatchQueue.main.async {
            self.namesTableView.reloadData()
        }
    }
    @IBOutlet private var tableViewModel: NamesTableViewModel!
    @IBOutlet private weak var namesTableView: UITableView!
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainPageViewModel()
        dissapearLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.namesTableView.reloadData()
        }
    }
    
    private func dissapearLabel() {
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.warningLabel.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier, let tableViewModel = tableViewModel else { return }
        if id == "detailsSegue" {
            if let dvc = segue.destination as? DetailsVC {
                dvc.detailsViewModel = tableViewModel.viewModelForSelectedRow()
            }
        }
    }
}

extension MainPageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID
                                                 , for: indexPath) as? NamesTableViewCell
        guard let tableViewCell = cell else { return .init()}
        let cellViewModel = tableViewModel?.cellViewModel(indexPath: indexPath)
        tableViewCell.viewModel = cellViewModel as? NamesTableViewCellViewModel
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tableViewModel = tableViewModel else { return }
        tableViewModel.selectRow(atIndexPath: indexPath)
        
        performSegue(withIdentifier: "detailsSegue", sender: nil)
    }
}
