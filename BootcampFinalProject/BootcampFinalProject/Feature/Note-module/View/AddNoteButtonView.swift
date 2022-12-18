//
//  AddNoteButtonView.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 28.11.2022.
//

import UIKit

protocol AddNoteButtonViewDelegate: AnyObject {
    func pushViewController()
}


final class AddNoteButtonView: UIView {

    //MARK: - Property
    weak var delegate: AddNoteButtonViewDelegate?
    
    //MARK: - initilize
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    private func customInit() {
        let nib = UINib(nibName: "AddNoteButtonView", bundle: nil)
        if let view = nib.instantiate(withOwner: self).first as? UIView {
            addSubview(view)
            view.frame = self.bounds
        }
    }
    
    //MARK: - IBActions
    @IBAction func addButtonClicked(_ sender: Any) {
        print("Button pressed")
        delegate?.pushViewController()
    }
}
