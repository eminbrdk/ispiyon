//
//  UIView + Ext.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 13.03.2023.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    func makeSidesPadding(items: UIView..., padding: CGFloat) {
        for item in items {
            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                item.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
            ])
        }
    }
}
