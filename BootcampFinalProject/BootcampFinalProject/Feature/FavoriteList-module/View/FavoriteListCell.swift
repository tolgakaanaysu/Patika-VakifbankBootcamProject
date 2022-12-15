//
//  FavoriteListCell.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 14.12.2022.
//

import UIKit

final class FavoriteListCell: UITableViewCell {
    //MARK: - IBOutlet
    @IBOutlet private weak var nameLabel: UILabel!
    
    //MARK: - Property
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    //MARK: - Methods
    func configureCell(with favoriteGame: FavoriteGame){
        nameLabel.text = favoriteGame.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
    }
    
}
