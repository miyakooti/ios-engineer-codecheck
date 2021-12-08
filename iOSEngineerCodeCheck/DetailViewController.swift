//
//  DetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var stargazersLabel: UILabel!
    @IBOutlet private weak var wachersLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var issuesLabel: UILabel!
    
    var repository: [String: Any]?

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
    
    }
    
    private func prepareViews() {
        guard let repository = repository else { return }
        
        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        stargazersLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        wachersLabel.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        issuesLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
    }
    
    private func getImage() {
        guard let repository = repository,
              let owner = repository["owner"] as? [String: Any],
              let imageURL = owner["avatar_url"] as? String else { return }
        
        titleLabel.text = repository["full_name"] as? String
        
        URLSession.shared.dataTask(with: URL(string: imageURL)!) { [weak self] (data, res, err) in
            let image = UIImage(data: data!)!
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }.resume()
    }
    
}
