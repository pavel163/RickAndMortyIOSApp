//
//  RMCharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by b.r.ergashev on 12.11.2023.
//
import UIKit

import Foundation

final class RMCharacterDetailsViewController: UIViewController {
    private let viewModel: RMCharacterDetailsViewModel
    
    private let detailsView: RMCharacterDetailsView
    
    init(viewModel: RMCharacterDetailsViewModel) {
        self.viewModel = viewModel
        self.detailsView = RMCharacterDetailsView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsopported")
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubviews(detailsView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare)
        )
        addConstrains()
        
        detailsView.collectionView?.delegate = self
        detailsView.collectionView?.dataSource = self
    }
    
    @objc
    private func didTapShare() {}

    private func addConstrains() {
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            detailsView.leftAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leftAnchor
            ),
            detailsView.rightAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.rightAnchor
            ),
            detailsView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
}

extension RMCharacterDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .information(let viewModels):
            return viewModels.count
        case .episodes(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterPhotoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
        case .information(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterInfoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .episodes(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterEpisodeCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
}
