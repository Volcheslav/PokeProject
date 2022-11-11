//
//  NetworkManagerProtocol.swift
//  PokeProject
//
//  Created by User on 11.11.22.
//

import Foundation

protocol DataManagerProtocol {
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void)
}
