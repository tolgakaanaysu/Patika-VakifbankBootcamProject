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
    func cellForRowAt(at indexPath: IndexPath) -> Note
    func didSelectRowAt(at indexPath: IndexPath)
    func trailingSwipeActionsConfigurationForRowAt(at indexPath: IndexPath)
    
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
    
    func cellForRowAt(at indexPath: IndexPath) -> Note {
        noteList[indexPath.row]
    }
    
    func didSelectRowAt(at indexPath: IndexPath) {
        let note = noteList[indexPath.row]
        view?.preparePresent(note: note)
    }
    
    func trailingSwipeActionsConfigurationForRowAt(at indexPath: IndexPath) {
        let note = noteList[indexPath.row]
        deleteNote(note: note)
       
    }
    
    //MARK: - Private Methods
    @objc private func getAllNote(){
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
                self?.view?.showSuccessAlert(message: success.message)
                self?.getAllNote()
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
