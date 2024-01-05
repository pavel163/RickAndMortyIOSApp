//
//  RMCharacterPhonoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Bakht Ergashev on 04.01.2024.
//

import UIKit

class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterPhonoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setUpConstrains() {}
    
    public func configure(with viewModel: RMCharacterDetailsPhotoViewCellViewModel) {}
}
