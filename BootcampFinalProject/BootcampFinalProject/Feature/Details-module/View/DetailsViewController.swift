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
}

final class DetailsViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var textView: UITextView!
    
    //MARK: - Property
    private lazy var viewModel: DetailsViewModelDelegate = DetailsViewModel()
    var id: Int?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id else { return }
        viewModel.view = self
        viewModel.viewDidLoad(id: id)
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
}
