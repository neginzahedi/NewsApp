//
//  DataModels.swift
//  NewsApp
//
//  Created by Negin Zahedi on 2024-03-11.
//

import Foundation

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
