//
//  IspTabbarController.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 13.03.2023.
//

import UIKit

class IspTabbarController: UITabBarController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        viewControllers = [createIspiyonlaNC(), createIspiyonlarNC()]
    }
    
    func createIspiyonlaNC() -> UINavigationController {
        let ispiyonlaVC = IspiyonlaVC()
        ispiyonlaVC.title = "İspiyonla"
        ispiyonlaVC.tabBarItem = UITabBarItem(title: "ispiyonla", image: UIImage(systemName: "pencil"), tag: 0)
        
        return UINavigationController(rootViewController: ispiyonlaVC)
    }
    
    func createIspiyonlarNC() -> UINavigationController {
        let ispiyonlarVC = IspiyonlarVC()
        ispiyonlarVC.title = "İspiyonlar"
        ispiyonlarVC.tabBarItem = UITabBarItem(title: "ispiyonlar", image: UIImage(systemName: "folder.fill"), tag: 1)
        
        return UINavigationController(rootViewController: ispiyonlarVC)
    }
}
