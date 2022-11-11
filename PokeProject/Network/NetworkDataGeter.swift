//
//  NetworkDataGeter.swift
//  PokeProject
//
//  Created by User on 11.11.22.
//

import Foundation

class NetworkDataGeter: DataGeterProtocol {
    
    private var networkDataFetcher: DataFetcherProtocol
    
    init(networkDataFetcher: DataFetcherProtocol) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func fetchDetailsList(urlString: String, completion: @escaping (PokemonDetailsNetworkModel?, String?) -> Void) {
        networkDataFetcher.fetchData(urlString: urlString, completion: completion)
        }
    
    func fetchNamesList(urlString: String, completion: @escaping (PokemonNamesListMainModel?, String?) -> Void) {
        networkDataFetcher.fetchData(urlString: urlString, completion: completion)
        }
}
