//
//  NetworkManagerProtocol.swift
//  PokeProject
//
//  Created by User on 11.11.22.
//

import Foundation

protocol NetworkDataManagerProtocol {
    func request(urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}
