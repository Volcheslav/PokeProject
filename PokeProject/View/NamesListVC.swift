//
//  MainPageVC.swift
//  PokeProject
//
//  Created by User on 28.10.22.
//

import UIKit

final class NamesListVC: UIViewController {
    
    private let cellID  = "nameCell"
    
    var viewModel: NamesListViewModel?
    
    @IBOutlet private weak var warningLabel: UILabel!
    
    @IBAction private func goMainScreen(_ sender: UIStoryboardSegue) {
        
    }
    
    @IBAction private func leftSwipeUpdate(_ sender: UISwipeGestureRecognizer) {
        if NetworkMonitor.shared.isConnected == true {
            tableViewModel.goLeftPage()
            DispatchQueue.main.async {
                self.namesTableView.reloadData()
            }}
        
    }
    @IBAction private func rightSwipeUpdate(_ sender: UISwipeGestureRecognizer) {
        if NetworkMonitor.shared.isConnected == true {
            tableViewModel.goRightPage()
            DispatchQueue.main.async {
                self.namesTableView.reloadData()
            }
        }
    }
    @IBOutlet private var tableViewModel: NamesListTableViewModel!
    @IBOutlet private weak var namesTableView: UITableView!
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = NamesListViewModel()
        dissapearLabel()
        NetworkMonitor.shared.startMonitoring()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if NetworkMonitor.shared.isConnected != true {
            tableViewModel.getFromRealm()
        }
        
        guard let text = viewModel?.returnText(isConnected: NetworkMonitor.shared.isConnected ?? false) else { return }
        self.warningLabel.text = text
        
        DispatchQueue.main.async {
            self.namesTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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

extension NamesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID
                                                 , for: indexPath) as? NamesListTableViewCell
        guard let tableViewCell = cell else { return .init()}
        let cellViewModel = tableViewModel?.cellViewModel(indexPath: indexPath)
        tableViewCell.viewModel = cellViewModel as? NamesListTableViewCellViewModel
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tableViewModel = tableViewModel else { return }
        tableViewModel.selectRow(atIndexPath: indexPath)
        performSegue(withIdentifier: "detailsSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.frame.height / 10
        return height
    }
}
