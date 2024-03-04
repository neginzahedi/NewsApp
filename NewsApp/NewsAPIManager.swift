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
    static let topHeadLinesURL = URL(string:"https://newsapi.org/v2/top-headlines?country=us&apiKey=\(Configuration.myAPIKey)")
    
    @Published var articles = [Article]()
    
    private init(){}
    
    public func fetchTopNews() async throws -> [Article] {
        let url = NewsAPIManager.topHeadLinesURL!
        let (data, _) = try await URLSession.shared.data(from: url)
        let responseData = try JSONDecoder().decode(NewsAPIResponse.self, from: data)
        return responseData.articles
    }
}

// MARK: - Models

struct NewsAPIResponse: Codable{
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Codable{
    let id: String?
    let name: String?
}

