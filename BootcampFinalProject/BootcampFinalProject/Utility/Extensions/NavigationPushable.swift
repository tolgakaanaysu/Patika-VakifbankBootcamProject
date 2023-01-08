//
//  NavigationPushable.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 17.12.2022.
//

import UIKit

protocol NavigationPushable {
    func pushViewController(with viewControllerID: String)
    func popViewController()
}

extension NavigationPushable where Self: UIViewController {
    func pushViewController(with viewControllerID: String) {
        let viewController = storyboard!.instantiateViewController(identifier: viewControllerID)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
