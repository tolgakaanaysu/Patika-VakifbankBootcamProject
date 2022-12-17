//
//  NoteListVC.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 17.12.2022.
//

import UIKit

protocol NoteListVCDelegate: AnyObject, Alert, NavigationPushable {
    func prepareTableView()
    func tableViewReloadData()
}

final class NoteListVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet private weak var noteTableView: UITableView!
    
    //MARK: - Property
    private lazy var viewModel = NoteListViewModel()
    
    //MARK: - Lifecycle
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
//        let note = viewModel.cellForRowAt(at: indexPath)
        //TODO: cell
        return .init()
    }
}

extension NoteListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(at: indexPath)
    }
}

//MARK: - NoteListVCDelegate
extension NoteListVC: NoteListVCDelegate {
    
    func prepareTableView() {
        noteTableView.delegate = self
        noteTableView.dataSource = self
    //TODO: register nib
    }
    
    func tableViewReloadData() {
        noteTableView.reloadData()
    }
}
