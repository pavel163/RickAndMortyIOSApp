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
        
        RMService.shared.execute(.listCharactersRequests) { (result: Result<RMGetAllCharactersResponse, Error>) in
            switch result {
            case .success(let model):
                print(String(describing: model))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
