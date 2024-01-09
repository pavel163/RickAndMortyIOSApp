//
//  RMCharacterDetailsInfoViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Bakht Ergashev on 05.01.2024.
//

import UIKit

final class RMCharacterDetailsInfoViewCellViewModel {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone  = .current
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle  = .short
        return formatter
    }()
    
    private let type: `Type`
    
    private let value: String
    
    public var title: String {
        type.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty {
            return "None"
        }
        
        if type == .created,
           let date = Self.dateFormatter.date(from: value) {
            return Self.shortDateFormatter.string(from: date)
        }
        
        return value
    }
    
    public var displayIcon: UIImage? {
        type.icon
    }
    
    public var tintColor: UIColor {
        type.tintColor
    }
    
    enum `Type`: String {
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount
        
        var tintColor: UIColor {
            switch self {
            case .status:
                return .systemBlue
            case .gender:
                return .systemRed
            case .type:
                return .systemCyan
            case .species:
                return .systemGray
            case .origin:
                return .systemGreen
            case .created:
                return .systemRed
            case .location:
                return .systemYellow
            case .episodeCount:
                return .systemRed
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "")
            case .gender:
                return UIImage(systemName: "")
            case .type:
                return UIImage(systemName: "")
            case .species:
                return UIImage(systemName: "")
            case .origin:
                return UIImage(systemName: "")
            case .created:
                return UIImage(systemName: "")
            case .location:
                return UIImage(systemName: "")
            case .episodeCount:
                return UIImage(systemName: "")
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status,
                 .gender,
                 .type,
                 .species,
                 .origin,
                 .created,
                 .location:
                return rawValue.uppercased()
            case .episodeCount:
                return "EPISODE COUNT"
            }
        }
    }
    
    init(value: String, type: Type) {
        self.type = type
        self.value = value
    }
}
