//
//  DetailPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by Arai Kousuke on 2021/12/08.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

protocol DetailPresenterOutput {
    func updateImageView(image: UIImage)
    func handleIntialData(repository: [String: Any])
}

protocol DetailPresenterInput {
    var repository: [String : Any] { get }
    func handleInitialDataAndFetchImage(repository: [String: Any])
}


final class DetailPresenter: DetailPresenterInput {
    
    private(set) var repository: [String : Any] = [:]

    private var view: DetailViewController
    private var model: DetailModelInput
    
    
    init(view: DetailViewController, model: DetailModelInput) {
        self.view = view
        self.model = model
    }
    
    func handleInitialDataAndFetchImage(repository: [String : Any]) {
        self.repository = repository
        view.handleIntialData(repository: repository)
        
        guard let owner = repository["owner"] as? [String: Any],
              let imageURL = owner["avatar_url"] as? String else { return }
        
        model.fetchImage(imageURL: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.view.updateImageView(image: image)
                }

            case .failure(let error):
                print(error)
            }
            
        }
    }
    
}
