//
//  RMImageLoader.swift
//  RickAndMorty
//
//  Created by Bakht Ergashev on 03.01.2024.
//

import Foundation

final class ImageLoader {
    
    static let shared = ImageLoader()
    
    private let imageDataCache = NSCache<NSString, NSData>()
    
    public func download(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as Data))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            let key = url.absoluteString as NSString
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        
        task.resume()
    }
}
