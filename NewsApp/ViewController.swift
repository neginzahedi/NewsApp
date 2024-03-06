//
//  ViewController.swift
//  NewsApp
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Variables
    private var articles: [Article] = []
    private var viewModels = [NewsTableViewCellViewModel]()
    
    // MARK: - UI Components
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        fetchData()
    }
    
    
    // MARK: - Setup UI
    private func setupUI(){
        
        self.title = "News"
        self.view.backgroundColor = .blue
        
        self.view.addSubview(tableView) // Adding tableView to the view hierarchy
        self.tableView.frame = view.bounds
    }
    
    // MARK: - Methods
    private func fetchData() {
        Task {
            do {
                self.articles = try await NewsAPIManager.shared.fetchTopNews()
                
                self.viewModels = articles.compactMap({ article in
                    NewsTableViewCellViewModel(
                        title: article.title ?? "Title",
                        author: article.author ?? "Author",
                        imageURL: URL(string: article.urlToImage ?? "")
                    )
                })
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
}

// MARK: - Extention
extension ViewController:  UITableViewDelegate, UITableViewDataSource {
    
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    // what cell we want to use to pass info
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // custom NewsTableViewCell
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsTableViewCell.identifier,
            for: indexPath
        ) as? NewsTableViewCell else {
            fatalError("The tableView could not dequeue a NewsTableViewCell  in ViewController.")
        }
        
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
