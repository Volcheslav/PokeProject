//
//  MainPageViewModel.swift
//  PokeProject
//
//  Created by User on 2.11.22.
//

import Foundation

class NamesListViewModel {
    
    private var warningText = "Swipe left and right to change list"
    private var connectionText = "No connection"
    
    var text: String {
        return warningText
    }
    
    func returnText(isConnected: Bool) -> String {
        if isConnected {
            return warningText
        } else {
            return connectionText
        }
    }

}
