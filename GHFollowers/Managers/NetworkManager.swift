//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by William Adams on 2/28/25.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completionHandler: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completionHandler(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completionHandler(.success(followers))
            } catch {
                completionHandler(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
