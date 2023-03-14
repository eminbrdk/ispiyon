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
    
    let topContainerView = UIView() // stackview i viewe ekliyeceksin. view in constrainlerini ayarlayacaksın
    let topView = UIStackView()
    let vehicleType = IspTitleLabel()
    let plaque = IspTitleLabel()
    
    let user = IspSecondaryTitleLabel()
    let complaint = IspTextLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
        configureVehicleTypeAndPlaque()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(vehicleType: String, plaque: String, user: String, complaint: String) {
        self.vehicleType.text = vehicleType + "  -  "
        self.plaque.text = plaque
        self.user.text = user
        self.complaint.text = complaint
    }
    
    private func configureCell() {
        addSubview(backView)
        backView.addSubviews(topContainerView, user, complaint)
        
        backgroundColor = IspColors.viewBackgroundColor
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.backgroundColor = IspColors.viewBackgroundColor
        backView.layer.cornerRadius = 8
        
        backView.makeSidesPadding(items: topContainerView, user, complaint, padding: 7)
        makeSidesPadding(items: backView, padding: 10)
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            topContainerView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 5),
            topContainerView.heightAnchor.constraint(equalToConstant: 25),
            
            user.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 5),
            user.heightAnchor.constraint(equalToConstant: 25),
            
            complaint.topAnchor.constraint(equalTo: user.bottomAnchor, constant: 5),
            complaint.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -5)
        ])
    }
    
    private func configureVehicleTypeAndPlaque() {
        topContainerView.addSubview(topView)
        topView.addArrangedSubview(vehicleType)
        topView.addArrangedSubview(plaque)
        
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.axis = .horizontal
        topView.alignment = .leading
        topView.distribution = .fill
    }
}
