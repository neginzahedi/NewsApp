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
}
