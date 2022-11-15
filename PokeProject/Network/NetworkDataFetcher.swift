//
//  NetworkDataFetcher.swift
//  PokeProject
//
//  Created by User on 31.10.22.
//

import Foundation

class NetworkDataFetcher: DataFetcherProtocol {
    
    private var networkManager: NetworkDataManagerProtocol
    private enum ErrorMessages: String {
        case noData = "NO_DATA"
        case code = "ERR_CODE"
        case error = "ERROR"
        case decodeError = "DECODE_ERROR"
    }
    
    init(networkManager: NetworkDataManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchData<T: Codable>(urlString: String, completion: @escaping (T?, String?) -> Void) {
        networkManager.request(urlString: urlString) { (data, response, error) in
            var errorMessage: String?
            if data == nil {
                let resp = response as? HTTPURLResponse
                errorMessage =
                "\((ErrorMessages.noData.rawValue)§)\n\((ErrorMessages.code.rawValue)§) \(resp?.statusCode ?? 0)\n\((ErrorMessages.error.rawValue)§) \(error?.localizedDescription ?? "")\n"
            }
            
            let decoded = self.decodeJson(type: T.self, from: data)
            if decoded.0 != nil {
                completion(decoded.0, nil)
            } else {
                if errorMessage != nil {
                    errorMessage! += "\((ErrorMessages.decodeError.rawValue)§) \(decoded.1 ?? "")"
                } else {
                    errorMessage = "\((ErrorMessages.decodeError.rawValue)§) \(decoded.1 ?? "")"
                }
                completion(nil, errorMessage)}
        }
    }
    
   private func decodeJson<T:Codable>(type: T.Type, from: Data?) -> (T?, String?) {
        let decoder = JSONDecoder()
       guard let data = from else { return (nil, (ErrorMessages.noData.rawValue)§) }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return (objects, nil)
        } catch let jsonError {
            return (nil, jsonError.localizedDescription)
        }
    }
    
}
