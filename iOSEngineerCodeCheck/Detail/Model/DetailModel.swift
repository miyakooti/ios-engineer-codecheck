//
//  DetailModel.swift
//  iOSEngineerCodeCheck
//
//  Created by Arai Kousuke on 2021/12/08.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

protocol DetailModelInput {
    func fetchImage(imageURL: String, completion: @escaping (Result<UIImage>) -> ())
}

class DetailModel: DetailModelInput {
    
    func fetchImage(imageURL: String, completion: @escaping (Result<UIImage>) -> ()) {
        guard let url = URL(string: imageURL) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, res, err) in
            guard let data = data else { return }
            if err == nil, let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(err))
            }
            
        }.resume()

    }
    
}
