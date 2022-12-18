//
//  FavoriteListVC.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 15.12.2022.
//

import UIKit

protocol FavoriteListVCDelegate: AnyObject, SeguePerformable, Alert {
    func tableViewReloadData()
    func prepareTableView()
}

final class FavoriteListVC: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet private weak var favoriteListTableView: UITableView!
  
    
    //MARK: - Property
    lazy var viewModel = FavoriListViewModel()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    //MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           guard let destinationVC = segue.destination as? DetailsViewController else { return }
        destinationVC.id = viewModel.selectedFavoriteGame?.integerID
    }
}

//MARK: - UITableViewDataSource
extension FavoriteListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteListCell.identifier,
                                                       for: indexPath) as? FavoriteListCell else { return .init() }
        let favoriGame = viewModel.cellForRowItem(at: indexPath.row)
        cell.configureCell(with: favoriGame)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension FavoriteListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteButton = UIContextualAction(style: .destructive, title: "DELETE") {[weak self] action, view, bool in
            self?.viewModel.deleteButtonAction(at: indexPath.row)
        }
        return UISwipeActionsConfiguration(actions: [deleteButton])
    }
}

//MARK: -  FavoriteListVCDelegate
extension FavoriteListVC: FavoriteListVCDelegate {
    
    func prepareTableView() {
        favoriteListTableView.delegate = self
        favoriteListTableView.dataSource = self
        favoriteListTableView.register(FavoriteListCell.nib, forCellReuseIdentifier: FavoriteListCell.identifier)
        navigationItem.title = LocalizableConstant.favoriteListTitle
    }
    
    func tableViewReloadData() {
        favoriteListTableView.reloadData()
    }
}
