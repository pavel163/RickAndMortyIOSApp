//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by b.r.ergashev on 30.10.2023.
//

import UIKit

final class RMCharacterViewController: UIViewController, RMCharacterListViewDelegate {
    private let characterListView = RMCharacterListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"

        view.addSubview(characterListView)
        
        characterListView.delegate = self

        NSLayoutConstraint.activate(
            [
                characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ]
        )
    }
    
    func characterListView(_ characterListView: RMCharacterListView, selectedCharacter: RMCharacter) {
        let viewModel = RMCharacterDetailsViewModel(character: selectedCharacter)
        let detailsVC = RMCharacterDetailsViewController(viewModel: viewModel)
        detailsVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
