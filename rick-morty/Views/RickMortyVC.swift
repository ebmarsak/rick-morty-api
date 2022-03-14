//
//  RickMortyVC.swift
//  rick-morty
//
//  Created by Teto on 1.03.2022.
//

import UIKit
import SnapKit

class RickMortyVC: UIViewController {
    
    var characterCount = 0
    var page = 1
    var hasMoreContent = true
    var characters: Character?
    var results: [Result] = []
    let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters(page: page)
        configureTableView()
        tableView.reloadData()
        
    }
}

extension RickMortyVC {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: "charCell")
        tableView.rowHeight = 200
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension RickMortyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "charCell", for: indexPath) as! CharacterTableViewCell
        
        cell.idLabel.text = String(results[indexPath.row].id)
        cell.nameLabel.text = results[indexPath.row].name
        cell.speciesLabel.text = results[indexPath.row].species
        cell.getImageFromURL(id: String(results[indexPath.row].id))
        cell.statusLabel.text = results[indexPath.row].status
        cell.genderLabel.text = results[indexPath.row].gender
        cell.locationLabel.text = results[indexPath.row].location.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreContent else { return }
            page += 1
            fetchCharacters(page: page)
        }
    }
}

// MARK: - Network Call

extension RickMortyVC {
    
    func fetchCharacters(page: Int) {
        
        NetworkManager.shared.fetchCharacters(page: page) { [weak self]
            result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                if self.results.count < self.characterCount { self.hasMoreContent = false }
                
                self.results += response.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(_):
                return
            }
        }
    }
    
    func fetchCharacterCount() {
        NetworkManager.shared.fetchCharacterCount() { [weak self]
            result in
            guard let self =  self else { return }
            
            switch result {
            case .success(let response):
                self.characterCount = response.info.count
            case .failure(_):
                return
                
            }
        }
    }
}
