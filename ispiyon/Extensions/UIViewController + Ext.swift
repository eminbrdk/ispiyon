//
//  NavigationItem + Ext.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 13.03.2023.
//

import Foundation
import Firebase

extension UIViewController {
    
    func applyDefaultScreenSettings() {
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        view.backgroundColor = IspColors.viewBackgroundColor
    }
    
    func makeSidesPadding(items: UIView..., padding: CGFloat) {
        for item in items {
            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                item.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
    }
    
    func addSignOutButtonToRight() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Çıkış", style: .done, target: self, action: #selector(signOutPressed))
    }
    
    @objc func signOutPressed() {
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
        present(nc, animated: true)
    }
}
