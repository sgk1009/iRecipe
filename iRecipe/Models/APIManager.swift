//
//  ModelData.swift
//  iRecipe
//
//  Created by Sydney King on 8/12/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case badGateWay
    case invalidData
}


class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
    func fetchData<T: Decodable>(from endpoint: String) async throws -> T {
        //access API through endpoint url
        guard let url = URL(string: endpoint) else{
            throw APIError.invalidURL
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            if httpResponse.statusCode == 502 {
                throw APIError.badGateWay
            }else{
                throw APIError.invalidResponse
            }
        }
        //decode JSON
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        }catch{
            if let dataString = String(data: data, encoding: .utf8) {
                print("Fetched data: \(dataString)")
            }
            throw APIError.invalidData
        }
    }
}

