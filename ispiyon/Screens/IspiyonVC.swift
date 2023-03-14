//
//  IspiyonVC.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 13.03.2023.
//

import UIKit

class IspiyonVC: UIViewController {

    let topContainerView = UIView() // stackview i viewe ekliyeceksin. view in constrainlerini ayarlayacaksın
    let topView = UIStackView()
    let vehicleType = IspTitleLabel()
    let plaque = IspTitleLabel()
    
    let user = IspSecondaryTitleLabel()
    let complaint = IspTextLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyDefaultScreenSettings()
        addSignOutButtonToRight()
        configureStackView()
        configureView()
    }
    
    func set(vehicleType: String, plaque: String, user: String, complaint: String) {
        self.vehicleType.text = vehicleType + "  -  "
        self.plaque.text = plaque
        self.user.text = user
        self.complaint.text = complaint
    }
    
    func configureStackView() {
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.axis = .horizontal
        topView.alignment = .leading
        topView.distribution = .fill
    }
    
    func configureView() {
        view.addSubviews(topContainerView, user, complaint)
        topContainerView.addSubview(topView)
        topView.addArrangedSubview(vehicleType)
        topView.addArrangedSubview(plaque)
        
        view.makeSidesPadding(items: topContainerView, user, complaint, padding: 7)
        
        NSLayoutConstraint.activate([
            topContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topContainerView.heightAnchor.constraint(equalToConstant: 25),
            
            user.topAnchor.constraint(equalTo: topContainerView.bottomAnchor, constant: 10),
            user.heightAnchor.constraint(equalToConstant: 25),
            
            complaint.topAnchor.constraint(equalTo: user.bottomAnchor, constant: 15)
        ])
    }
}
