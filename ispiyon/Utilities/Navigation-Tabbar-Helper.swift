//
//  Navigation-Tabbar-Helper.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 14.03.2023.
//

import UIKit

struct NavTabControllerHelper {
    
    static func configureNavigationController() {
        UINavigationBar.appearance().barTintColor = IspColors.viewBackgroundColor
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    static func configureTabbarController() {
        UITabBar.appearance().barTintColor = IspColors.viewBackgroundColor
        UITabBar.appearance().tintColor = .white
    }
}
