//
//  AlertsManager.swift
//  PokeProject
//
//  Created by User on 11.11.22.
//

import UIKit

extension UIViewController {
    
    func showAlertWithCancelButn(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addCancelAction()
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Extension alert controller
extension UIAlertController {
    func addCancelAction () {
        let cancelAction = UIAlertAction(title: ("CANCEL")§, style: .cancel)
        self.addAction(cancelAction)
    }
}
