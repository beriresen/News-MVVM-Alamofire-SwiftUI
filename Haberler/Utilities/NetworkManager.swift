//
//  NetworkManager.swift
//  Projects
//
//  Created by BRR on 7.08.2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class NetworkManager {
    
    static let instance = NetworkManager()
    private let cache           = NSCache<NSString, UIImage>()
    
    let headers : HTTPHeaders = [
        "Accept": "*/*",
        "User-Agent": "Mozilla/5.0 (compatible; Rigor/1.0.0; http://rigor.com)"
    ]
    
    public func fetch<T:Codable> (_ method: HTTPMethod, apiMethod: Methods, requestModel: [String:Any]?, model: T.Type, completed: @escaping (Result<T, NetworkError>) -> Void)
    {
        guard let url = URL(string: Constant.baseURL + apiMethod.rawValue) else {
            completed(.failure(.invalidURL))
            return
        }
        
        AF.request(url, method: method, parameters: requestModel, encoding: URLEncoding(destination: .queryString), headers: headers)
            .validate()
            .responseData { response in
                
                if let _ =  response.error {
                    completed(.failure(.unableToComplete))
                    return
                }
                
                else if response.response?.statusCode != 200 {
                    completed(.failure(.invalidResponse))
                    return
                }
                
                guard response.data != nil else {
                    completed(.failure(.invalidData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    print(response.data!)
                    let decodedResponse = try decoder.decode(T.self, from: response.data!)
                    completed(.success(decodedResponse))
                } catch {
                    completed(.failure(.invalidData))
                }
            }
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}

