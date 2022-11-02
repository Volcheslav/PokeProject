//
//  NetworkConnectionCheck.swift
//  PokeProject
//
//  Created by User on 2.11.22.
//

import Foundation
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()

    var isConnected: Bool?
    let monitor = NWPathMonitor()

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.isConnected = true
            } else {
                self?.isConnected = false
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
