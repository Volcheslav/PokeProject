//
//  MainPageViewModel.swift
//  PokeProject
//
//  Created by User on 2.11.22.
//

import Foundation

class NamesListViewModel: NameListViewModelProtocol {
    
    private var networkMonitor: NetworkMonitorProtocol?
    
    init(networkMonitor: NetworkMonitorProtocol?) {
        self.networkMonitor = networkMonitor
        self.networkMonitor?.startMonitoring()
    }
    
    func returnConnectionState() -> Bool? {
        return networkMonitor?.isConnected
    }

}
