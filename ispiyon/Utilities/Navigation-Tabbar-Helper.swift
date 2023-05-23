//
//  Navigation-Tabbar-Helper.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 14.03.2023.
//

import UIKit

struct NavTabControllerHelper {
    
    static func configureNavigationAndTabbarController() {
        UINavigationBar.appearance().tintColor = IspColors.appColor
        UITabBar.appearance().tintColor = IspColors.appColor
    }
}
