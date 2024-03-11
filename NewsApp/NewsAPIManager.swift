//
//  NewsAPIManager.swift
//  NewsApp
//
//  Created by Negin Zahedi on 2024-03-04.
//

import Foundation

class NewsAPIManager {
    
    // MARK: - Properties
    
    static let shared = NewsAPIManager()
    static let topHeadLinesURL = URL(string:"https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=\(Configuration.myAPIKey)")
    
    @Published var articles = [Article]()
    
    private init(){}
    
    public func fetchTopNews() async throws -> [Article] {
        let url = NewsAPIManager.topHeadLinesURL!
        let (data, _) = try await URLSession.shared.data(from: url)
        let responseData = try JSONDecoder().decode(NewsAPIResponse.self, from: data)
        return responseData.articles
    }
}

