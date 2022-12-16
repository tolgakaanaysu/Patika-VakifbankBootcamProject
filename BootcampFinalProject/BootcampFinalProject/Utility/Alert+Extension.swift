//
//  Alert+Extension.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 15.12.2022.
//

import UIKit
import ProgressHUD


protocol Alert {
    func showErrorAlert(message: String)
    func showSuccessAlert(message: String)
    func startProgressAnimating()
    func stopAnimating()
}

extension Alert where Self: UIViewController {
    func showErrorAlert(message: String) {
        ProgressHUD.colorBackground = .lightGray
        ProgressHUD.showError(message)
    }
    
    func showSuccessAlert(message: String) {
        ProgressHUD.fontStatus = .boldSystemFont(ofSize: 30)
        ProgressHUD.colorBackground = .darkGray
        ProgressHUD.showSuccess(message)
    }
    
    func startProgressAnimating(){
        ProgressHUD.colorBackground = .lightGray
        ProgressHUD.colorAnimation = .blue
        ProgressHUD.animationType = .circleSpinFade
        ProgressHUD.show()
    }
        
    func stopAnimating(){
        ProgressHUD.dismiss()
    }
}
