//
//  HomepageViewController.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 13.12.2022.
//

import UIKit

protocol HomepageViewControllerDelegate: AnyObject {
    
}

final class HomepageViewController: UIViewController {
    //MARK: - Property
    private lazy var viewModel: HomepageViewModelDelegate = HomepageViewModel()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension HomepageViewController: HomepageViewControllerDelegate {
    
}
