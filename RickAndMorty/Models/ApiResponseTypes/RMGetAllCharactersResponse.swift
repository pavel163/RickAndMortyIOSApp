//
//  RMGetAllCharactersResponse.swift
//  RickAndMorty
//
//  Created by b.r.ergashev on 03.11.2023.
//

import Foundation

struct RMGetAllCharactersResponse: Codable {
    
    let info: RMGetAllCharactersResponseInfo
    let results: [RMCharacter]
    
    struct RMGetAllCharactersResponseInfo: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
}
