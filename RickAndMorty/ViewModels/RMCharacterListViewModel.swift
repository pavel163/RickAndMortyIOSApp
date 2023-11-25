//
//  RMCharacterListViewModel.swift
//  RickAndMorty
//
//  Created by b.r.ergashev on 06.11.2023.
//

import UIKit

protocol RMCharacterListViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didLoadMoreCharacters(with newIndexPath: [IndexPath])
    func didSelectCharacter(_ character: RMCharacter)
}

final class RMCharacterListViewModel: NSObject {
    weak var delegate: RMCharacterListViewModelDelegate?
    
    private var isLoadingMore: Bool = false
    
    private var characters: [RMCharacter] = []
    
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
        
    private var apiInfo: RMGetAllCharactersResponse.RMGetAllCharactersResponseInfo? = nil
    
    func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequests) { [weak self] (result: Result<RMGetAllCharactersResponse, Error>) in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self?.apiInfo = responseModel.info
                self?.putCharacters(newCharacters: results)
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    private func putCharacters(newCharacters: [RMCharacter]) {
        characters.append(contentsOf: newCharacters)
        newCharacters.forEach { character in
            let viewModel = RMCharacterCollectionViewCellViewModel(
                name: character.name,
                status: character.status,
                image: URL(string: character.image)
            )
            cellViewModels.append(viewModel)
        }
    }
    
    func fetchAdditionalCharacters(url: URL) {
        guard !isLoadingMore else {
            return
        }
        
        isLoadingMore = true
        print("Fetching more characters \(url.absoluteString)")
        guard let rmRequest = RMRequest(url: url) else {
            return
        }
                
        RMService.shared.execute(rmRequest) { [weak self] (result: Result<RMGetAllCharactersResponse, Error>) in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.results
                
                let newCount = moreResults.count
                let startIndex = strongSelf.characters.count
                let indexPathToAdd: [IndexPath] = Array(startIndex..<(startIndex+newCount)).compactMap {
                    IndexPath(row: $0, section: 0)
                }
                
                strongSelf.apiInfo = responseModel.info
                strongSelf.putCharacters(newCharacters: moreResults)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacters(with: indexPathToAdd)
                    strongSelf.isLoadingMore = false
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}

extension RMCharacterListViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        
        cell.configure(with: cellViewModels[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                  ofKind: kind,
                  withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
                  for: indexPath
              ) as? RMFooterLoadingCollectionReusableView
        else {
            fatalError("Unsupported")
        }
        
        footer.startAnimation()
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.item]
        delegate?.didSelectCharacter(character)
    }
}

extension RMCharacterListViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMore,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString),
              scrollView.contentOffset.y > 0.0
        else {
            return
        }
        
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalScrollViewFixedHeight = scrollView.frame.size.height
        
        if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
            fetchAdditionalCharacters(url: url)
        }
    }
}
 
