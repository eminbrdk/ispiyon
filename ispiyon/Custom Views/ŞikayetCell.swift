//
//  ŞikayetCell.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 13.03.2023.
//

import UIKit

class SikayetCell: UITableViewCell {

    static let reuseID = "şikayetID"
    
    let backView = UIView()
    let heading = IspTitleLabel()
    let user = IspSecondaryTitleLabel()
    let complaint = IspTextLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(vehicleType: String, plaque: String, user: String, complaint: String) {
        self.heading.text = vehicleType + " - " + plaque
        self.user.text = user
        self.complaint.text = complaint
    }
    
    private func configureCell() {
        addSubview(backView)
        backView.addSubviews(heading, user, complaint)
        
        backgroundColor = .systemBackground
        selectionStyle = .none
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.backgroundColor = .systemGray5
        backView.layer.cornerRadius = 8
        
        backView.makeSidesPadding(items: heading, user, complaint, padding: 7)
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            backView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            heading.topAnchor.constraint(equalTo: backView.topAnchor, constant: 5),
            heading.heightAnchor.constraint(equalToConstant: 25),
            
            user.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 5),
            user.heightAnchor.constraint(equalToConstant: 25),
            
            complaint.topAnchor.constraint(equalTo: user.bottomAnchor, constant: 5),
            complaint.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -5)
        ])
    }
}
