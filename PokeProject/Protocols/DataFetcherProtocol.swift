//
//  DataFetcherProtocol.swift
//  PokeProject
//
//  Created by User on 11.11.22.
//

import Foundation

protocol DataFetcherProtocol {
    func fetchData<T: Codable>(urlString: String, completion: @escaping (T?, String?) -> Void)
}
