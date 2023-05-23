//
//  NavigationItem + Ext.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 13.03.2023.
//

import UIKit
import Firebase

extension UIViewController {
    
    func applyDefaultScreenSettings() {
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        view.backgroundColor = .systemBackground
    }
    
    func addSignOutButtonToRight() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Çıkış", style: .done, target: self, action: #selector(signOutPressed))
    }
    
    @objc func signOutPressed() {
        let alert = UIAlertController(title: "Çıkış", message: "Uygulamadan çıkmak istediğinize emin misiniz?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "İptal", style: .cancel))
        alert.addAction(UIAlertAction(title: "Çıkış Yap", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            
            do {
                try FirebaseAuth.Auth.auth().signOut()
            } catch {
                return
            }
            
            let welcomeVC = WelcomeVC()
            welcomeVC.title = "ispik"
            
            let nc = UINavigationController(rootViewController: welcomeVC)
            nc.modalPresentationStyle = .fullScreen
            nc.modalTransitionStyle = .crossDissolve
            self.present(nc, animated: true)
        }))
        
        present(alert, animated: true)
    }
    
    func presentIspAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = IspAlertVC(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
}
