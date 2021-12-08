//
//  SearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    private var repositories: [[String: Any]] = []
    private var task: URLSessionTask?
    private var searchText = ""
    private var urlString = ""
    private var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.text = "ios-engineer-codecheck"
        searchBar.delegate = self
        tableView.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            guard let detailVC = segue.destination as? DetailViewController,
                  let index = index else { return }
            detailVC.repository = repositories[index]
        }
    }
    
}


extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }
    
}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard searchBar.text != "", let text = searchBar.text else { return }
        searchText = text
        urlString = "https://api.github.com/search/repositories?q=\(searchText)"
        
        guard let url = URL(string: urlString) else { return }

        task = URLSession.shared.dataTask(with: url) { [weak self] (data, res, err) in
            
            guard let data = data else { return }

            do {
                guard let obj = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let items = obj["items"] as? [[String: Any]] else { return }
                self?.repositories = items
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch {
                print(error)
                return
            }
            

        }
        task?.resume()
    }
    
}
