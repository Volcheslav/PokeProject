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
        self.details = DetailsModel()
        details?.name = data.name
    }
    
    init(url: String) {
        self.url = url
        self.getDetails()
        //print(self.data)
        //self.setDetails()
        //print(self.details?.name)
    }
}
