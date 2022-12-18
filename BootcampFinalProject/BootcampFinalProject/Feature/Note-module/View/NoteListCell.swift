//
//  FavoriteListCell.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 17.12.2022.
//

import UIKit

final class NoteListCell: UITableViewCell {
    //MARK: - IBOutlet
    @IBOutlet private weak var gameNameLabel: UILabel!
    @IBOutlet private weak var noteTitleLabel: UILabel!
    @IBOutlet private weak var noteDateLabel: UILabel!
    
    //MARK: - Property
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    //MARK: - Methods
    func configureCell(with model: Note){
        gameNameLabel.text = model.gameName
        noteDateLabel.text = model.date
        noteTitleLabel.text = model.text
        selectionStyle = .none
    }
}
