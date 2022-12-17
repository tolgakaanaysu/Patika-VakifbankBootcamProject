//
//  DetailsViewController.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 14.12.2022.
//

import UIKit
import Kingfisher
protocol DetailsViewControllerDelegate: Alert {
    func dataNotFound()
    func prepareInterfaceComponent(game: GameDetail)
    func changeButtonColor(_ gameIsFavorite: Bool)
}

final class DetailsViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    //MARK: - Property
    private lazy var viewModel: DetailsViewModelDelegate = DetailsViewModel()
    var id: Int?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id else { return }
        viewModel.id = id
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    @IBAction func favoriteButtonClicked(_ sender: Any) {
        viewModel.favoriteButtonClicked()
    }
}

//MARK: - DetailsViewControllerDelegate
extension DetailsViewController: DetailsViewControllerDelegate {
    func dataNotFound() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.popViewController(animated: true)
            self?.viewModel.sendNotificationForDataNotFound()
        }
    }
    
    func prepareInterfaceComponent(game: GameDetail) {
        nameLabel.text = game.name
        ratingLabel.text = game.rating.toString()
        textView.text = game.descriptionRaw
        let url = URL(string: game.backgroundImageAdditional)
        imageView.kf.setImage(with: url)
    }
    
    func changeButtonColor(_ gameIsFavorite: Bool) {
        favoriteButton.tintColor = gameIsFavorite ? .systemRed : .lightGray
    }
}
