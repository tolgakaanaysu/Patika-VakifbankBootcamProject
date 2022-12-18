//
//  NoteListViewModel.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 17.12.2022.
//

import Foundation

protocol NoteListViewModelDelegate {
    var view: NoteListVCDelegate? { get }
    
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func cellForRowAt(at index: Int) -> Note
    func didSelectRowAt(at index: Int)
    func trailingSwipeActionsConfigurationForRowAt(at index: Int)
    
}

final class NoteListViewModel: NoteListViewModelDelegate {
    //MARK: - Property
    weak var view: NoteListVCDelegate?
    private var noteList = [Note]() {
        didSet{
            view?.tableViewReloadData()
        }
    }
    
    //MARK: - Lifecycle
    func viewDidLoad() {
        view?.prepareTableView()
        getAllNote()
        observeNote()
    }
    
    //MARK: - TableViewMethods
    func numberOfRowsInSection() -> Int {
        noteList.count
    }
    
    func cellForRowAt(at index: Int) -> Note {
        noteList[index]
    }
    
    func didSelectRowAt(at index: Int) {
        let note = noteList[index]
        view?.preparePresent(note: note)
    }
    
    func trailingSwipeActionsConfigurationForRowAt(at index: Int) {
        let note = noteList[index]
        deleteNote(note: note)
       
    }
    
    //MARK: - Private Methods
    @objc func getAllNote(){
        CoreDataNoteClient.shared.getAllNote { [weak self] result in
            switch result {
            case .success(let notes):
                self?.noteList = notes
            case .failure(let error):
                self?.view?.showErrorAlert(message: error.message)
            }
        }
    }
    
    private func deleteNote(note: Note){
        CoreDataNoteClient.shared.deleteNote(note: note) { [weak self] result in
            switch result {
            case .success(let success):
                self?.getAllNote()
                self?.view?.showSuccessAlert(message: success.message)
                
            case .failure(let error):
                self?.view?.showErrorAlert(message: error.message)
            }
        }
    }
    
    private func observeNote(){
        CommunicationBetweenModules.shared.observe(observer: self,
                                                   name: CommunicationMessage.noteListChanged.rawValue,
                                                   selector: #selector(getAllNote))
    }
}
