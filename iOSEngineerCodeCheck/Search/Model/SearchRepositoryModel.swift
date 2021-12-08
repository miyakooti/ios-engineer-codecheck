//
//  SearchRepositoryModel.swift
//  iOSEngineerCodeCheck
//
//  Created by Arai Kousuke on 2021/12/08.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchRepositoryModelInput {
    func fetchRepositories(text: String, completion: @escaping (Result<[[String: Any]]>) -> ())
}

final class SearchRepositoryModel: SearchRepositoryModelInput {
    
    private var task: URLSessionTask?
    
    func fetchRepositories(text: String, completion: @escaping (Result<[[String: Any]]>) -> ()) {
        
        let urlString = "https://api.github.com/search/repositories?q=\(text)"

        
        guard let url = URL(string: urlString) else { return }

        
        URLSession.shared.dataTask(with: url) { [weak self] (data, res, err) in
            
            
        }
        
        task = URLSession.shared.dataTask(with: url) { [weak self] (data, res, err) in
            guard let data = data else { return }

            do {
                guard let obj = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let items = obj["items"] as? [[String: Any]] else { return }
                completion(.success(items))
            } catch {
                print(error)
                completion(.failure(err))
            }

        }
        task?.resume()
    }
    
    
}



public enum Result<T> {
    case success(T)
    case failure(Any)
}
