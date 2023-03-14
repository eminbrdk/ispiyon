//
//  IspTextView.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 13.03.2023.
//

import UIKit

class IspTextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.borderWidth = 1
        layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
        layer.cornerRadius = 7
        backgroundColor = .black
        
        textAlignment = .left
        textColor = .white
        font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        autocorrectionType = .no
        contentInsetAdjustmentBehavior = .automatic
    }
}
