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
        
        layer.borderWidth = 2
        layer.borderColor = CGColor(gray: 0.5, alpha: 1)
        layer.cornerRadius = 7
        backgroundColor = .systemBackground
        
        textAlignment = .left
        textColor = .label
        font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        autocorrectionType = .no
        contentInsetAdjustmentBehavior = .automatic
    }
}
