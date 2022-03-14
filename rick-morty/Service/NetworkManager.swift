//
//  NetworkManager.swift
//  rick-morty
//
//  Created by Teto on 1.03.2022.
//

import UIKit
import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://rickandmortyapi.com/api"
    private let testImageURL = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
    
    private init() {}
    
    
    func fetchCharacters(page: Int, completed: @escaping (Swift.Result<Character, Error>) -> Void) {
        
        let endpoint = baseURL + "/character/?page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let characters = try decoder.decode(Character.self, from: data)
                completed(.success(characters))
            } catch {
                return
            }
        }
        
        task.resume()
    }
    
    func fetchCharacterCount(completed: @escaping (Swift.Result<Character, Error>) -> Void) {
        
        let endpoint = baseURL + "/character)"
        
        guard let url = URL(string: endpoint) else {
            
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let characterCount = try decoder.decode(Character.self, from: data)
                completed(.success(characterCount))
            } catch {
                return
            }
        }
        
        task.resume()
    }
}
