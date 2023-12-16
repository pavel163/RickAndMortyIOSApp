//
//  RMCharacterDetailsViewController.swift
//  RickAndMorty
//
//  Created by b.r.ergashev on 12.11.2023.
//
import UIKit

import Foundation

final class RMCharacterDetailsViewController : UIViewController {
    private let viewModel: RMCharacterDetailsViewModel
    
    init(viewModel: RMCharacterDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsopported")
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }

}
