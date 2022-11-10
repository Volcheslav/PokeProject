//
//  UIIamgeViewExtension.swift
//  PokeProject
//
//  Created by User on 2.11.22.
//

import UIKit

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else { return }

        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let imageData = try? Data(contentsOf: url),
                  let loadedImage = UIImage(data: imageData) else { return }
            DispatchQueue.main.async {
                self?.image = loadedImage
            }
        }
    }
}
