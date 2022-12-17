//
//  FavoriteListCell.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 17.12.2022.
//

import UIKit

class NoteListCell: UITableViewCell {

    @IBOutlet private weak var gameNameLabel: UILabel!
    @IBOutlet private weak var noteTitleLabel: UILabel!
    @IBOutlet private weak var noteDateLabel: UILabel!
    
    func configureCell(with model: Note){
        gameNameLabel.text = model.text
        noteDateLabel.text = model.date
        noteTitleLabel.text = model.text
    }
}
