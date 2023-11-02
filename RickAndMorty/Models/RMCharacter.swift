//
//  RMCharacter.swift
//  RickAndMorty
//
//  Created by b.r.ergashev on 30.10.2023.
//

import Foundation

struct RMCharacter : Codable {
    let id: Int
    let name: String
    let status: RMCharacterStatus
    let species: String
    let type: String
    let gender: RMCharacterGender
    let origin: RMOrigin
    let location: RMCharacterLocation
    let image : String
    let episode: [String]
    let url: String
    let created: String
}
