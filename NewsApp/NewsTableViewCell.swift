//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Negin Zahedi on 2024-03-06.
//

import UIKit

class NewsTableViewCellViewModel {
    let title: String
    let author: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, author: String, imageURL: URL?, imageData: Data? = nil) {
        self.title = title
        self.author = author
        self.imageURL = imageURL
        self.imageData = imageData
    }
}

class NewsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "NewsTableViewCell"
    
    private let tableViewCellTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private let tableViewCellSubTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private let tableViewcellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemFill
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    // MARK: - Setup UI
    private func setupUI(){
        self.contentView.addSubview(tableViewCellTitle)
        self.contentView.addSubview(tableViewCellSubTitleLabel)
        self.contentView.addSubview(tableViewcellImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableViewCellTitle.frame = CGRect(
            x: 160,
            y: 0,
            width: contentView.frame.width - 170,
            height: 100
        )
        
        tableViewCellSubTitleLabel.frame = CGRect(
            x: 160,
            y: 70,
            width: contentView.frame.width - 170,
            height: contentView.frame.size.height/2
        )
        
        tableViewcellImage.frame = CGRect(
            x: 20,
            y: 10,
            width:130,
            height: 110
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.tableViewCellTitle.text = nil
        self.tableViewCellSubTitleLabel.text = nil
    }
    
    // MARK: - Configure
    public func configure(with viewModel:  NewsTableViewCellViewModel){
        tableViewCellTitle.text = viewModel.title
        tableViewCellSubTitleLabel.text = viewModel.author
        
        if let data = viewModel.imageData{
            tableViewcellImage.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            // fetch
            Task {
                do {
                    try await fetchImage(viewModel: viewModel, url: url)
                } catch{
                    print("error fetch image")
                }
            }
        }
    }
    
    func fetchImage(viewModel:NewsTableViewCellViewModel,url : URL) async throws {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        viewModel.imageData = data
        DispatchQueue.main.async {
            self.tableViewcellImage.image = UIImage(data: data)
        }
    }
}
