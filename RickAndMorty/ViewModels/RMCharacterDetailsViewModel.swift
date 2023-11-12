//
//  RMCharacterDetailsViewModel.swift
//  RickAndMorty
//
//  Created by b.r.ergashev on 12.11.2023.
//

import Foundation

final class RMCharacterDetailsViewModel {
    private let character: RMCharacter
    
    init(character: RMCharacter){
        self.character = character
    }
    
    var title: String {
        character.name.uppercased()
    }
}
