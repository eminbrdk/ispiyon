//
//  IspTitleLabel.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 13.03.2023.
//

import UIKit

class IspTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textAlignment = .left
        font = UIFont.systemFont(ofSize: 23, weight: .bold)
        textColor = .label
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        numberOfLines = 1
        lineBreakMode = .byTruncatingTail
    }

}
