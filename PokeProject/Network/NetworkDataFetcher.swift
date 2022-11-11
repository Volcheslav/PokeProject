//
//  NetworkDataFetcher.swift
//  PokeProject
//
//  Created by User on 31.10.22.
//

import Foundation

class NetworkDataFetcher: DataFetcherProtocol {
    
    private var networkManager: DataManagerProtocol
    
    init(networkManager: DataManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchData<T: Codable>(urlString: String, completion: @escaping (T?) -> Void) {
        networkManager.request(urlString: urlString) { (data, error) in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
                completion(nil)
            }
            let decoded = self.decodeJson(type: T.self, from: data)
            completion(decoded)
        }
    }
    
   private func decodeJson<T:Codable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("FAIL TO DECODE JSON", jsonError)
            return nil
        }
    }
    
}
