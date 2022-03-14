//
//  CharacterTableViewCell.swift
//  rick-morty
//
//  Created by Teto on 1.03.2022.
//

import UIKit
import SnapKit

class CharacterTableViewCell: UITableViewCell {
    
    let idLabel = UILabel()
    let nameLabel = UILabel()
    let statusLabel = UILabel()
    let speciesLabel = UILabel()
    let typeLabel = UILabel()
    let genderLabel = UILabel()
    let originLabel = UILabel()
    let locationLabel = UILabel()
    var charImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Configure Cell Layout
extension CharacterTableViewCell {
    
    func configSubviews() {
        
        addSubview(idLabel)
        addSubview(nameLabel)
        addSubview(statusLabel)
        addSubview(speciesLabel)
        addSubview(genderLabel)
        addSubview(locationLabel)
        addSubview(charImageView)
        
        // Details
        nameLabel.text = "Carl Johnson"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        nameLabel.numberOfLines = 0
        
        charImageView.layer.cornerRadius = 16
        charImageView.clipsToBounds = true
        
        
        // Constraints
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(charImageView)
            make.left.equalTo(charImageView.snp.right).offset(10)
            make.height.equalTo(20)
        }
        
        charImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.height.width.equalTo(160)
        }
        
        speciesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.equalTo(charImageView.snp.right).offset(10)
            make.height.equalTo(20)
        }
        
        statusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(speciesLabel.snp.bottom)
            make.left.equalTo(charImageView.snp.right).offset(10)
            make.height.equalTo(20)
        }
        
        genderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(statusLabel.snp.bottom)
            make.left.equalTo(charImageView.snp.right).offset(10)
            make.height.equalTo(20)
        }
        
        locationLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(charImageView.snp.bottom)
            make.left.equalTo(charImageView.snp.right).offset(10)
            make.height.equalTo(20)
        }
        
        idLabel.snp.makeConstraints { (make) in
            make.top.equalTo(charImageView.snp.bottom)
            make.centerX.equalTo(charImageView)
        }
    }
}

// MARK: - Network call for ImageView
extension CharacterTableViewCell {
    
    func getImageFromURL(id: String) {
        
        let url: URL = URL(string: "https://rickandmortyapi.com/api/character/avatar/\(id).jpeg")!

        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    self?.charImageView.image = UIImage(data: data)
                }
            }
        }
        
        dataTask.resume()
    }
    
   
}
