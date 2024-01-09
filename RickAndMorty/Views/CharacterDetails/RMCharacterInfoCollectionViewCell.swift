//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Bakht Ergashev on 04.01.2024.
//

import UIKit

class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMCharacterInfoCollectionViewCell"
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .light)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let icon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubviews(titleContainerView, valueLabel, icon)
        
        titleContainerView.backgroundColor = .secondarySystemBackground
        titleContainerView.addSubviews(titleLabel)
        setUpConstrains()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        valueLabel.text = nil
        titleLabel.text = nil
        icon.image = nil
        icon.tintColor = .label
    }
    
    private func setUpConstrains() {
        NSLayoutConstraint.activate(
            [
                titleContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                titleContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
                
                titleLabel.leftAnchor.constraint(equalTo: titleContainerView.leftAnchor),
                titleLabel.rightAnchor.constraint(equalTo: titleContainerView.rightAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
                titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
                
                valueLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 10),
                valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
                valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
                valueLabel.bottomAnchor.constraint(equalTo: titleContainerView.topAnchor),

                
                icon.heightAnchor.constraint(equalToConstant: 30),
                icon.widthAnchor.constraint(equalToConstant: 30),
                icon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
                icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            ]
        )
    }

    public func configure(with viewModel: RMCharacterDetailsInfoViewCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayValue
        icon.image = viewModel.displayIcon
        icon.tintColor = viewModel.tintColor
    }
}
