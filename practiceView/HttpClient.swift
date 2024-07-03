//
//  HttpClient.swift
//  practiceView
//
//  Created by KKNANXX on 7/2/24.
//

import Foundation
import SwiftUI

enum AppError: Error {
    case badData
    case badURL
    case badResponse
    case decoderError
}

enum NetworkRequest: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
}

class HttpClient{
    func fetch<T:Decodable>(urlString: String) async throws -> T {
        
        //check if this is a valid url
        guard let url = URL(string: urlString) else{
            throw AppError.badURL
        }
        
        // build a URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = NetworkRequest.get.rawValue
        
        // use url session make request throught the url
        let(data, response) = try await URLSession.shared.data(for: request)
        
        // need to make sure the status number is between the range
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else{
            throw AppError.badResponse
        }
        
        //then change the format to decodable type -> with json decoder
        do {
            //print("Raw Data: \(String(data: data, encoding: .utf8) ?? "No data")")
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            //print("Decoded Data: \(decodedData)")
            return decodedData
        } catch {
            //print("Decoding Error: \(error)")
            throw AppError.decoderError
        }
    }
}
