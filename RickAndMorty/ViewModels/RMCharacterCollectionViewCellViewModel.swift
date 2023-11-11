//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by b.r.ergashev on 11.11.2023.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel {
    public let name: String
    private let status: RMCharacterStatus
    private let image: URL?
    
    public var statusText: String {
        return status.rawValue
    }
    
    init(
        name: String,
        status: RMCharacterStatus,
        image: URL?
    ) {
        self.name = name
        self.status = status
        self.image = image
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = image else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
