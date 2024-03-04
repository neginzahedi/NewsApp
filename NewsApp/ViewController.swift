//
//  ViewController.swift
//  NewsApp
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Variables
    private var articles: [Article] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    
    // MARK: - Setup UI
    private func setupUI(){
        self.title = "News App"
        self.view.backgroundColor = .systemBackground
        
        fetchNews()
    }
    
    // MARK: - Methods
    private func fetchNews(){
        Task {
            do {
                self.articles = try await NewsAPIManager.shared.fetchTopNews()
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
}

