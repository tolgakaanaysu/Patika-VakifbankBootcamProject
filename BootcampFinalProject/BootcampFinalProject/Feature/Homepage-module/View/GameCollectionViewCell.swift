//
//  GameCollectionViewCell.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 13.12.2022.
//

import UIKit
import SDWebImage
class GameCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlet
    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var view: UIView!
    @IBOutlet weak var cellWidth: NSLayoutConstraint!
    //MARK: - Property
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
    
    
    override func prepareForReuse() {
        backgroundImage.image = UIImage(systemName: "photo")
        ratingLabel.text = ""
        nameLabel.text = ""
    }
    
    func configureCell(with model: Game) {
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 15
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        ratingLabel.text = model.rating.toString()
        nameLabel.text = model.name
//        guard let url = URL(string: model.imageUrl) else {
//            print("url error")
//            return
//        }
//        backgroundImage.sd_setImage(with: url)
    }
}
