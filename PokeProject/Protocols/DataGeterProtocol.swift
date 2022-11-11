//
//  DataGeterProtocol.swift
//  PokeProject
//
//  Created by User on 11.11.22.
//

import Foundation

protocol DataGeterProtocol {
    func fetchDetailsList(urlString: String, completion: @escaping (PokemonDetailsNetworkModel?, String?) -> Void)
    
    func fetchNamesList(urlString: String, completion: @escaping (PokemonNamesListMainModel?, String?) -> Void) 
}
