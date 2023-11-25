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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
        if #available(iOS 17.0, *) {
            registerForTraitChanges([UITraitUserInterfaceStyle.self]) { (self: Self, _: UITraitCollection) in
                self.setUpLayer()
            }
        }
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, nameLabel, statusLabel)
        addConstraints()
        setUpLayer()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate(
            [
                statusLabel.heightAnchor.constraint(equalToConstant: 30),
                nameLabel.heightAnchor.constraint(equalToConstant: 30),
                
                statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
                statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
                nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
                nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
                
                statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -3),
                
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3)
            ]
        )
    }
    
    private func setUpLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.secondaryLabel.cgColor
        contentView.layer.cornerRadius = 4
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.3
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if UIDevice.current.systemVersion.compare("17.0", options: .numeric) == .orderedAscending {
            setUpLayer()
        }
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
