//
//  ButtonExtension.swift
//  PokeProject
//
//  Created by User on 12.11.22.
//

import UIKit

extension UIButton {
    
    func animateButton() {
        UIView.animate(
            withDuration: 0.3,
            animations: { [unowned self] in
                self.transform = .init(scaleX: 0.9, y: 0.8)
            },
            completion: { [unowned self] _ in
                self.transform = .identity
            }
        )
    }
}
