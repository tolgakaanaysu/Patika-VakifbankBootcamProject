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
        //TODO: perform segue
        
    }
    
    //MARK: - Private Methods
    private func getAllNote(){
        CoreDataNoteClient.shared.getAllNote { [weak self] result in
            switch result {
            case .success(let notes):
                self?.noteList = notes
            case .failure(let error):
                self?.view?.showErrorAlert(message: error.message)
            }
        }
    }
}

//MARK: - AddNoteButtonViewDelegate
extension NoteListViewModel: AddNoteButtonViewDelegate {
    func pushViewController() {
        view?.pushViewController(with: "")
    }
}
