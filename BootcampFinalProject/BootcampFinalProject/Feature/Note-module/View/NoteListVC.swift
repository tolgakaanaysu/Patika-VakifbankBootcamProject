//
//  NoteListVC.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 17.12.2022.
//

import UIKit

protocol NoteListVCDelegate: AnyObject, Alert, NavigationPresenable {
    func prepareTableView()
    func tableViewReloadData()
    func preparePresent(note: Note?)
}

final class NoteListVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet private weak var noteTableView: UITableView!
    
    //MARK: - Property
    private lazy var viewModel = NoteListViewModel()
    class var identifier: String {
        return String(describing: self)
    }
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        let frame = CGRect(x: noteTableView.frame.width / 2,
                           y: noteTableView.frame.height + 25,
                           width: 48, height: 48)
        let buttonView = AddNoteButtonView(frame: frame)
        buttonView.delegate = self
        view.addSubview(buttonView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension NoteListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteListCell.identifier, for: indexPath) as? NoteListCell else { return .init() }
        let note = viewModel.cellForRowAt(at: indexPath)
        cell.configureCell(with: note)
        return cell
    }
}

extension NoteListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteButton = UIContextualAction(style: .destructive, title: "DELETE") {[weak self] action, view, bool in
            self?.viewModel.trailingSwipeActionsConfigurationForRowAt(at: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [deleteButton])
    }
}

//MARK: - NoteListVCDelegate
extension NoteListVC: NoteListVCDelegate {
    
    func prepareTableView() {
        navigationItem.title = LocalizableConstant.noteListTitle
        noteTableView.delegate = self
        noteTableView.dataSource = self
        noteTableView.register(NoteListCell.nib, forCellReuseIdentifier: NoteListCell.identifier)
        noteTableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func tableViewReloadData() {
        noteTableView.reloadData()
    }
    
    func preparePresent(note: Note?) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: AddNewNoteVC.identifier) as? AddNewNoteVC else { return }
        vc.note = note
        present(vc, animated: true)
    }
}

extension NoteListVC: AddNoteButtonViewDelegate {
    func pushViewController() {
        present(with: AddNewNoteVC.identifier)
    }
}
