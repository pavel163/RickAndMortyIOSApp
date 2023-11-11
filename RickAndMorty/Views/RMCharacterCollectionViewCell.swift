//
//  RMCharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by b.r.ergashev on 11.11.2023.
//

import UIKit

final class RMCharacterCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .label
        nameLabel.font = .systemFont(
            ofSize: 18,
            weight: .medium
        )
        return nameLabel
    }()
    
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.textColor = .secondaryLabel
        statusLabel.font = .systemFont(
            ofSize: 16,
            weight: .regular
        )
        return statusLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, nameLabel, statusLabel)
        addConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate(
            [
                statusLabel.heightAnchor.constraint(equalToConstant: 40),
                nameLabel.heightAnchor.constraint(equalToConstant: 40),
                
                statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
                statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
                nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
                nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
                
                statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
                nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -3),
                
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3)
            ]
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    public func configure(with viewModel: RMCharacterCollectionViewCellViewModel) {
        nameLabel.text = viewModel.name
        statusLabel.text = viewModel.statusText
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
