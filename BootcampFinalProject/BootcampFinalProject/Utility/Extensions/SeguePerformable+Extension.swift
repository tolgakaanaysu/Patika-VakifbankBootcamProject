//
//  SegueConformable.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 14.12.2022.
//

import UIKit

protocol SeguePerformable {
    func performSegue(identifier: String)
}

extension SeguePerformable where Self: UIViewController {
    func performSegue(identifier: String){
        performSegue(withIdentifier: identifier, sender: self)
    }
}

protocol NavigationDelegate {
    func pushViewController(with viewControllerID: String)
    func popViewController()
}

extension NavigationDelegate where Self: UIViewController {
    func pushViewController(with viewControllerID: String) {
        let viewController = storyboard!.instantiateViewController(identifier: viewControllerID)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func popViewController(){
        navigationController?.popViewController(animated: true)
    }
}
