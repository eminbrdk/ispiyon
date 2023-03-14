//
//  WelcomeVC.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 13.03.2023.
//

import UIKit

class WelcomeVC: UIViewController {

    let welcomteText = IspTitleLabel()
    let buttonStackView = UIStackView()
    let loginButton = IspButton(title: "Giriş Yap", backgroundColor: IspColors.buttonColor1)
    let signUpButton = IspButton(title: "Kaydol", backgroundColor: IspColors.buttonColor2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyDefaultScreenSettings()
        configureButtonStackView()
    }
    
    func configureButtonStackView() {
        view.addSubviews(buttonStackView, welcomteText)
        
        buttonStackView.addArrangedSubview(loginButton)
        buttonStackView.addArrangedSubview(signUpButton)
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fill
        
        welcomteText.numberOfLines = 0
        welcomteText.text = "ispiğe hoşgeldiniz\ntoplu taşımalar yada taksi gibi ulaşım için kullanılan araçlar hakkında şikayetlerinizi belirtin ve başka şikayetleri görün"
        welcomteText.textAlignment = .center
        
        makeSidesPadding(items: buttonStackView, welcomteText, padding: 15)
        
        NSLayoutConstraint.activate([
            welcomteText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            welcomteText.heightAnchor.constraint(equalToConstant: 200),
            
            buttonStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 120),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        loginButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed(sender: UIButton!) {
        let authenticationVC = AuthenticationVC()
        authenticationVC.title = sender.titleLabel?.text
        authenticationVC.authenticationType = sender.titleLabel?.text == "Giriş Yap" ? .login : .signup
        
        navigationController?.pushViewController(authenticationVC, animated: true)
    }
}
