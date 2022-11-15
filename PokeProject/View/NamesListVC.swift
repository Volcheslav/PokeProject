//
//  MainPageVC.swift
//  PokeProject
//
//  Created by User on 28.10.22.
//

import UIKit

final class NamesListVC: UIViewController {
    
    // MARK: - Outlets
    // MARK: Interface elements
    
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var namesTableView: UITableView!
    
    // MARK: View Models
    
    @IBOutlet private var tableViewModel: NamesListTableViewModel!
    private var namesListViewModel: NameListViewModelProtocol?
    
    // MARK: - Actions
    
    @IBAction private func goLeftOnListAction(_ sender: UIButton) {
        backButton.animateButton()
        changePage(changeFunc: tableViewModel.goLeftPage)
    }
    
    @IBAction private func goRightOnListAction(_ sender: UIButton) {
        nextButton.animateButton()
        changePage(changeFunc: tableViewModel.goRightPage)
    }
    
    // MARK: Unwined segue
    
    @IBAction private func goMainScreen(_ sender: UIStoryboardSegue) {
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namesListViewModel = NamesListViewModel(networkMonitor: NetworkMonitor())
        tableViewModelPrepare()
        setInterface()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if namesListViewModel?.returnConnectionState() != true {
            setOfflineInterface()
        }
        
        DispatchQueue.main.async {
            self.namesTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if namesListViewModel?.returnConnectionState() != true {
            self.showAlertWithCancelButn(title: ("OFFLINE_ALERT_TITLE")§, message: ("OFFLINE_ALERT_MESSAGE")§)
        }
        if tableViewModel.errorMessage != nil {
            self.showAlertWithCancelButn(title: ("NETWORK_ERR_TITLE")§, message: tableViewModel.errorMessage!)
        }
    }
    
    // MARK: - Prepare segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier, let tableViewModel = tableViewModel else { return }
        if id == Constants.NamesListVCConstants.segueID {
            if let dvc = segue.destination as? DetailsVC {
                dvc.detailsViewModel = tableViewModel.viewModelForSelectedRow()
            }
        }
    }
    
    // MARK: - Paging function
    
    private func changePage(changeFunc: @escaping () -> Void) {
        if namesListViewModel?.returnConnectionState() == true {
            changeFunc()
            DispatchQueue.main.async {
                self.namesTableView.reloadData()
            }
        }
        changeButtonVisibility()
    }
    
    // MARK: - Set interface functions
    
    private func setInterface() {
        backButton.setTitle(("BACK_PAGE")§, for: .normal)
        nextButton.setTitle(("NEXT_PAGE")§, for: .normal)
        namesTableView.isScrollEnabled = false
        changeButtonVisibility()
    }
    
    private func tableViewModelPrepare() {
        tableViewModel = NamesListTableViewModel(
            networkDataGeter: NetworkDataGeter(
                networkDataFetcher: NetworkDataFetcher(
                    networkManager: NetworkManager())),
            realmManager: RealmManager())
        tableViewModel.fetchNames()
    }
    
    // MARK: Set interface in offline mode
    
    private func setOfflineInterface() {
        tableViewModel.getDataFromRealm()
        namesTableView.isScrollEnabled = true
        backButton.isHidden = true
        nextButton.isHidden = true
    }
    
    private func changeButtonVisibility() {
        backButton.isHidden = !tableViewModel.checkPreviousPageExists().0
        nextButton.isHidden = !tableViewModel.checkPreviousPageExists().1
    }
}

// MARK: - TableView Extensions

extension NamesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.NamesListVCConstants.cellID
                                                 , for: indexPath) as? NamesListTableViewCell
        guard let tableViewCell = cell else { return .init()}
        let cellViewModel = tableViewModel?.returnCellViewModel(indexPath: indexPath)
        tableViewCell.viewModel = cellViewModel as? NamesListTableViewCellViewModel
        
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tableViewModel = tableViewModel else { return }
        tableViewModel.selectRow(atIndexPath: indexPath)
        performSegue(withIdentifier: Constants.NamesListVCConstants.segueID, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.frame.height / Constants.NamesListVCConstants.cellsOnView
        return height
    }
}
