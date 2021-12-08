//
//  SearchRepositoryViewcontroller.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchRepositoryViewcontroller: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    // passiveviewなのでinputのみ
    private var presenter: SearchRepositoryPresenterInput!
    
    func inject(presenter: SearchRepositoryPresenterInput) {
        self.presenter = presenter
    }
    
    private var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = SearchRepositoryModel()
        let presenter = SearchRepositoryPresenter(view: self, model: model)
        self.inject(presenter: presenter)
        
        searchBar.text = "リポジトリを検索できるよーーー"
        searchBar.delegate = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            guard let detailVC = segue.destination as? DetailViewController,
                  let index = index else { return }
            detailVC.repository = presenter.repositories[index]
        }
    }
    
}


extension SearchRepositoryViewcontroller: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.repositories.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // このへんもおそらくpresenterの処理だからのちのち修正
        tableView.deselectRow(at: indexPath, animated: true)
        index = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
    
}

extension SearchRepositoryViewcontroller: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repository = presenter.repositories[indexPath.row]
        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }
    
}


extension SearchRepositoryViewcontroller: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // searchBar、viewにしか置けないのでここで判定するしか無い、、
        guard searchBar.text != "", let text = searchBar.text else { return }
        presenter.searchBarSearchButtonClicked(text: text)

    }
    
}

extension SearchRepositoryViewcontroller: SearchRepositoryPresenterOutput {
    func updateTableView(repositories: [[String : Any]]) {
        tableView.reloadData()
    }
    
}
