//
//  DetailsViewController.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 14.12.2022.
//

import UIKit
import SDWebImage
protocol DetailsViewControllerDelegate {
    func prepareInterfaceComponent(game: GameDetail)
    func changeButtonColor(_ gameIsFavorite: Bool)
    func showSuccessMessage(message: String)
    func showErrorMessage(message: String)
}

final class DetailsViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var favoriteButton: UIBarButtonItem!
    
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
    func prepareInterfaceComponent(game: GameDetail) {
        nameLabel.text = game.name
        ratingLabel.text = game.rating.toString()
        textView.text = game.descriptionRaw
        let url = URL(string: game.backgroundImageAdditional)
        imageView.sd_setImage(with: url)
    }
    
    func changeButtonColor(_ gameIsFavorite: Bool) {
        favoriteButton.tintColor = gameIsFavorite ? .systemYellow : .systemGray
    }
    
    func showSuccessMessage(message: String) {
        // Alert
        print(message)
    }
    
    func showErrorMessage(message: String) {
        // Alert
        print(message)
    }
}
