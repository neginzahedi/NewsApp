//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Negin Zahedi on 2024-03-04.
//

import Foundation

class NetworkManager {
    
    // MARK: - Properties
    
    static let shared = NetworkManager()
    static let topHeadLinesURL = URL(string:"https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=\(Configuration.myAPIKey)")
    
    // MARK: - init
    
    private init(){}
    
    // MARK: - Methods
    public func fetchTopNews() async throws -> [Article] {
        guard let url = NetworkManager.topHeadLinesURL else {
            throw NetworkError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let responseData = try JSONDecoder().decode(NewsAPIResponse.self, from: data)
        return responseData.articles
    }
}

// MARK: - Error Handling

enum NetworkError: Error {
    case invalidURL
}
