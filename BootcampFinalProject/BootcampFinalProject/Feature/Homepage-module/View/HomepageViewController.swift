//
//  HomepageViewController.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 13.12.2022.
//

import UIKit

protocol HomepageViewControllerDelegate: AnyObject {
    func prepareCollectionView()
}

final class HomepageViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet private weak var gameCollectionView: UICollectionView!
    
    //MARK: - Property
    private lazy var viewModel: HomepageViewModelDelegate = HomepageViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

//MARK: - CollectionViewDataSource
extension HomepageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.identifier ,for: indexPath) as? GameCollectionViewCell else {
            print("xib not found")
            return .init()
        }
        guard let game = viewModel.cellForItemAt(at: indexPath) else { return .init() }
        
        cell.configureCell(with: game)
        return cell
    }
}

//MARK: - HomepageViewControllerDelegate
extension HomepageViewController: HomepageViewControllerDelegate {
    func prepareCollectionView() {
        gameCollectionView.dataSource = self
        gameCollectionView.register(GameCollectionViewCell.nib, forCellWithReuseIdentifier: GameCollectionViewCell.identifier)
    }
}
