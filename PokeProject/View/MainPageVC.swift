//
//  MainPageVC.swift
//  PokeProject
//
//  Created by User on 28.10.22.
//

import UIKit

final class MainPageVC: UIViewController {
    
    private let cellID  = "nameCell"
        
   // var tableViewModel: TableViewModelType?
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.namesTableView.reloadData()
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
    
}
