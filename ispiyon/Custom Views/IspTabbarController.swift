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
    
    private func createIspiyonlaNC() -> UINavigationController {
        let vc = ComplainVC()
        vc.tabBarItem = UITabBarItem(title: "ispiyonla", image: UIImage(systemName: "pencil"), tag: 0)
        
        return UINavigationController(rootViewController: vc)
    }
    
    private func createIspiyonlarNC() -> UINavigationController {
        let vc = ComplaintsVC()
        vc.tabBarItem = UITabBarItem(title: "ispiyonlar", image: UIImage(systemName: "folder.fill"), tag: 1)
        
        return UINavigationController(rootViewController: vc)
    }
}
