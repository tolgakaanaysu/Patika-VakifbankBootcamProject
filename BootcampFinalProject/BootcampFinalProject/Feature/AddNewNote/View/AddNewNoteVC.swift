//
//  AddNewNoteVC.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 17.12.2022.
//

import UIKit

protocol AddNewNoteVCDelegate: AnyObject,Alert, NavigationPresenable {
    func configureComponents(with note: Note)
    func configureComponents()
}

final class AddNewNoteVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var gameNameTextField: UITextField!
    @IBOutlet private weak var noteTitleTextField: UITextField!
    @IBOutlet private weak var noteTextLabel: UITextView!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var editButton: UIButton!
    
    //MARK: - Property
    private lazy var viewModel = AddNewNoteViewModel()
    class var identifier: String {
        return String(describing: self)
    }
    var note: Note?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad(note: note)
    }
    
    //MARK: - IBAction method
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        checkTextFields()
        
        let newNote = NewNote(id: UUID().uuidString,
                              gameName: gameNameTextField.text!,
                              title: noteTitleTextField.text!,
                              text: noteTextLabel.text!)
        viewModel.saveNote(newNote: newNote)
    }
    
    @IBAction func editButtonClicked(_ sender: UIButton) {
        checkTextFields()
        
    }
    
    private func checkTextFields(){
        guard !noteTextLabel.text.isNilOrEmpty,
              !noteTitleTextField.text.isNilOrEmpty,
              !gameNameTextField.text.isNilOrEmpty else {
            showErrorAlert(message: "Label can not empty")
            gameNameTextField.layer.borderWidth = 1
            noteTitleTextField.layer.borderWidth = 1
            noteTextLabel.layer.borderWidth = 1
            gameNameTextField.layer.borderColor = UIColor.red.cgColor
            noteTitleTextField.layer.borderColor = UIColor.red.cgColor
            noteTextLabel.layer.borderColor = UIColor.red.cgColor
            return
        }
    }
}

extension AddNewNoteVC: AddNewNoteVCDelegate {
    func configureComponents() {
        titleLabel.text = "Add new note"
        editButton.removeFromSuperview()
    }
    
    func configureComponents(with note: Note) {
        titleLabel.textColor = .systemOrange
        titleLabel.text = "Edit the note"
        saveButton.removeFromSuperview()
        gameNameTextField.text = note.gameName
        noteTitleTextField.text = note.title
        noteTextLabel.text = note.text
    }
    
}
