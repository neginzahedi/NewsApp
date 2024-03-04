//
//  ViewController.swift
//  NewsApp
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Variables
    private var articles: [Article] = []
    
    // MARK: - UI Components
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        fetchNews()
    }
    
    
    // MARK: - Setup UI
    private func setupUI(){
        self.title = "News App"
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(tableView)
        self.tableView.frame = view.bounds
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

// MARK: - Extention
extension ViewController:  UITableViewDelegate, UITableViewDataSource {
    
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // what cell we want to use to pass info
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // custom NewsTableViewCell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        )
        cell.backgroundColor = .secondaryLabel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
