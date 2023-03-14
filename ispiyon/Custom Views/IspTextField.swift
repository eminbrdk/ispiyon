//
//  IspTextField.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 13.03.2023.
//

import UIKit

class IspTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        
        self.placeholder = placeholder
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.borderWidth = 1
        layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
        layer.cornerRadius = 7
        backgroundColor = .black
        
        textColor = .white
        textAlignment = .left
        
        attributedPlaceholder = NSAttributedString(
            string: "Placeholder Text",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        
        autocorrectionType = .no
        
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: frame.height))
        leftViewMode = .always
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: frame.height))
        rightViewMode = .always
    }
}
