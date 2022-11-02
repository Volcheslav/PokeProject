//
//  DetailsViewModel.swift
//  PokeProject
//
//  Created by User on 2.11.22.
//

import Foundation

class DetailsViewModel {
    
    var details: DetailsModel?
    
    var url: String?
    
    private var networkDataFetcher = NetworkDataFetcher()
    
    private func getDetails() {
        guard let url = url else { return }
        networkDataFetcher.fetchDetailsList(urlString: url) { (data) in
            self.details?.name = data?.name
            self.details?.height = data?.height
            self.details?.weight = data?.weight
            self.details?.sprites = data?.sprites.frontDefault
            self.details?.types = data?.types.map { $0.type.name }
            self.details?.id = data?.id
        }
    }
    
    init(url: String) {
        self.url = url
        self.getDetails()
    }
}
