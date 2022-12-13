//
//  GameCollectionViewCell.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 13.12.2022.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlet
    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
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
        
    }
}
