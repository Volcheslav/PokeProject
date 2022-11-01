//
//  NetworkDataFetcher.swift
//  PokeProject
//
//  Created by User on 31.10.22.
//

import Foundation

class NetworkDataFetcher {
    
    var networkManager = NetworkManager()
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func dataFetcher(urlString: String, completion: @escaping (NamesListMainModel?) -> Void) {
        networkManager.request(urlString: urlString) { (data, error) in
            let decoder = JSONDecoder()
            guard let data = data else { return }
            let response = try? decoder.decode(NamesListMainModel.self, from: data)
            completion(response)
        }
    }
    
}
