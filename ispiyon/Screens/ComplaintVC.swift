//
//  IspiyonVC.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 13.03.2023.
//

import UIKit

class ComplaintVC: UIViewController {

    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let heading = IspTitleLabel()
    let user = IspSecondaryTitleLabel()
    let complaint = IspTextLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureScrollView()
        configureCustomViews()
    }
    
    private func configureView() {
        title = "İspiyon"
        applyDefaultScreenSettings()
        addSignOutButtonToRight()
    }
    
    func set(vehicleType: String, plaque: String, user: String, complaint: String) {
        self.heading.text = vehicleType + "  -  " + plaque
        self.user.text = user
        self.complaint.text = complaint
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.makeSidesPadding(items: scrollView, padding: 0)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func configureCustomViews() {
        contentView.addSubviews(heading, user, complaint)
        contentView.makeSidesPadding(items: heading, user, complaint, padding: 7)
        
        heading.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            heading.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            user.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 10),
            user.heightAnchor.constraint(equalToConstant: 25),
            
            complaint.topAnchor.constraint(equalTo: user.bottomAnchor, constant: 15),
            
            contentView.bottomAnchor.constraint(equalTo: complaint.bottomAnchor)
        ])
    }
}
