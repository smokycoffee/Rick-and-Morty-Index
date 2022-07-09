//
//  NetworkManager.swift
//  Rick and Morty Indexes
//
//  Created by Tsenguun on 22/6/22.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>() // cache
    
    private init() {}
    
    let baseUrl = "https://rickandmortyapi.com/api/"
    
    func getArrayOfRicksAndMortys(page: Int, completed: @escaping(Result<ArrayOfRickAndMorty, RMError>) -> Void) {
        
        let endPoint = baseUrl + "character/?page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUrlLink))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let arrayOfRicksAndMortys = try decoder.decode(ArrayOfRickAndMorty.self, from: data)
                completed(.success(arrayOfRicksAndMortys))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
    
    func getCharInfo(get type: String,for id: Int, completed: @escaping(Result<RMCharacterInfo, RMError>) -> Void) {
        let endPoint = baseUrl + "\(type)/\(id)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUrlLink))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let characterInfo = try decoder.decode(RMCharacterInfo.self, from: data)
                completed(.success(characterInfo))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func getLocationInfo(get url: String, completed: @escaping(Result<RmLocationInfo, RMError>) -> Void) {
        guard let url = URL(string: url) else {
            completed(.failure(.invalidUrlLink))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let locationInfo = try decoder.decode(RmLocationInfo.self, from: data)
                completed(.success(locationInfo))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getOriginAndCurrentLocation(for url: String, completed: @escaping(Result<RMCharLocationCharInfo, RMError>) -> Void) {
        guard let url = URL(string: url) else {
            completed(.failure(.invalidUrlLink))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let characterInfo = try decoder.decode(RMCharLocationCharInfo.self, from: data)
                completed(.success(characterInfo))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
