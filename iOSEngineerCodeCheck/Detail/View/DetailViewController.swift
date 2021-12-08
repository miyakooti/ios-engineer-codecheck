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
    
    private var presenter: DetailPresenterInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = DetailModel()
        let presenter = DetailPresenter(view: self, model: model)
        self.inject(presenter: presenter)
        
        guard let repository = repository else { return }
        presenter.handleInitialDataAndFetchImage(repository: repository)
                
    }
    private func inject(presenter: DetailPresenterInput) {
        self.presenter = presenter
    }
    
}

extension DetailViewController: DetailPresenterOutput {
    
    func handleIntialData(repository: [String : Any]) {
        languageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        stargazersLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        wachersLabel.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        issuesLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        titleLabel.text = repository["full_name"] as? String ?? ""
    }
        
    func updateImageView(image: UIImage) {
        imageView.image = image
    }
    
}

