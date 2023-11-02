//
//  RMService.swift
//  RickAndMorty
//
//  Created by b.r.ergashev on 02.11.2023.
//

import Foundation

/// Primary API service object to get RIck and Morty data
final class RMService {
    
    /// Shared singlelon instance
    static let shared = RMService()
    
    private init() {}
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback  with data or error
    public func execute<T: Codable>(
        request: RMRequest,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
    }
}
    
