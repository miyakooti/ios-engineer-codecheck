//
//  SearchRepositoryPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by Arai Kousuke on 2021/12/08.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchRepositoryPresenterOutput {
    func updateTableView(repositories: [[String: Any]])
}

protocol SearchRepositoryPresenterInput {
    var repositories: [[String : Any]] { get }
    func searchBarSearchButtonClicked(text: String)
}

final class SearchRepositoryPresenter: SearchRepositoryPresenterInput {
    private(set) var repositories: [[String : Any]] = []
    
    var urlString = ""
    private var index: Int?
    
    private var view: SearchRepositoryPresenterOutput!
    private var model: SearchRepositoryModelInput
    
    init(view: SearchRepositoryPresenterOutput, model: SearchRepositoryModelInput) {
        self.view = view
        self.model = model
    }
    
    func searchBarSearchButtonClicked(text: String) {
        
        model.fetchRepositories(text: text) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.repositories = repositories
                DispatchQueue.main.async {
                    self?.view.updateTableView(repositories: repositories)
                }
            case .failure(let error):
                print()
            }
            
        }
    }
        
        


    
    
}
