//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by b.r.ergashev on 30.10.2023.
//

import UIKit

final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground        
        title = "Characters"
        
        let request = RMRequest(endpoint: .character)
        
        RMService.shared.execute(request: request) { (result: Result<String, Error>) in
        
        }
    }
}
