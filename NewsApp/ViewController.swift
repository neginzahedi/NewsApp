//
//  ViewController.swift
//  NewsApp
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }


    // MARK: - Setup UI
    private func setupUI(){
        self.title = "News App"
        self.view.backgroundColor = .systemBackground
    }
}

