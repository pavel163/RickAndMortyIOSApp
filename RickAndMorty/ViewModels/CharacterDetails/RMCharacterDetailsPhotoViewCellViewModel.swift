//
//  RMCharacterDetailsPhotoViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Bakht Ergashev on 05.01.2024.
//

import Foundation

final class RMCharacterDetailsPhotoViewCellViewModel {
    private let imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.download(url, completion: completion)
    }
}
