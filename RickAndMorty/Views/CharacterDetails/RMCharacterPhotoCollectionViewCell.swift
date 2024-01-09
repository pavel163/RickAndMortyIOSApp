//
//  RMCharacterPhonoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Bakht Ergashev on 04.01.2024.
//

import UIKit

class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterPhonoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.backgroundColor = .systemRed
        setUpConstrains()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    private func setUpConstrains() {
        NSLayoutConstraint.activate(
            [
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        )
    }
    
    public func configure(with viewModel: RMCharacterDetailsPhotoViewCellViewModel) {
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
