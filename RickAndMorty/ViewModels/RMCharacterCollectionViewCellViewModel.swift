//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by b.r.ergashev on 11.11.2023.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel: Hashable, Equatable {
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public let name: String
    private let status: RMCharacterStatus
    private let image: URL?
    
    public var statusText: String {
        return "Status: \(status.text)"
    }
        
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(status)
        hasher.combine(image)
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
        
        ImageLoader.shared.download(url, completion: completion)
    }
}
