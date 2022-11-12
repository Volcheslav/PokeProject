//
//  NetworkMonitorProtocol.swift
//  PokeProject
//
//  Created by User on 12.11.22.
//

import Foundation

protocol NetworkMonitorProtocol {
    var isConnected: Bool? { get }
    func startMonitoring()
    func stopMonitoring()
}
