//
//  DetailsViewModel.swift
//  PokeProject
//
//  Created by User on 2.11.22.
//

import Foundation

class DetailsViewModel {
    
    var details: DetailsModel?
    
    var data: DetailsNetworkModel?
    
    var url: String?
    
    private var networkDataFetcher = NetworkDataFetcher()
    
    //    private func getDetails() {
    //        guard let url = url else { return }
    //        networkDataFetcher.fetchDetailsList(urlString: url) { (data) in
    //            self.details?.name = data?.name
    //            self.details?.height = data?.height
    //            self.details?.weight = data?.weight
    //            self.details?.sprites = data?.sprites.frontDefault
    //            self.details?.types = data?.types.map { $0.type.name }
    //            self.details?.id = data?.id
    //        }
    //    }
    
    private func getDetails() {
        guard let url = url else { return }
        networkDataFetcher.fetchDetailsList(urlString: url) { [weak self] (data) in
            guard let self = self, let data = data else { return }
            self.data = data
            self.setDetails()
        }
    }
    private func setDetails() {
        guard let data = self.data else { return }
        let sprite = data.sprites.frontDefault != nil ? data.sprites.frontDefault! : "no data"
        self.details = DetailsModel(
            height: String(data.height),
            id: String(data.id),
            name: data.name,
            sprites: sprite,
            types: data.types.map { $0.type.name }.joined(separator: ", "),
            weight: String(data.weight))
    }
    
    init(url: String) {
        self.url = url
        self.getDetails()
    }
}
