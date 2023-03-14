//
//  AuthenticationVC.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 13.03.2023.
//

import UIKit
import Firebase

enum AuthenticationType {
    case login, signup
}

class AuthenticationVC: UIViewController {

    var authenticationType: AuthenticationType!
    let emailTextField = IspTextField(placeholder: "email")
    let passwordTextField = IspTextField(placeholder: "password")
    let enterButton = IspButton(title: "enter", backgroundColor: IspColors.buttonColor1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyDefaultScreenSettings()
        configureTextFields()
        configureCustomViews()
        arrangeViewForAuthenticationType()
        createDismissKeyboardTapGesture()
    }
    
// MARK: - Configure View
    
    func arrangeViewForAuthenticationType() {
        switch authenticationType {
        case .login:
            enterButton.setTitle("Giriş Yap", for: .normal)
            
        case .signup:
            enterButton.setTitle("Kaydol", for: .normal)
            
        case .none:
            return
        }
    }
    
    func configureTextFields() {
        view.addSubviews(emailTextField, passwordTextField)
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        emailTextField.resignFirstResponder()
        emailTextField.keyboardType = .emailAddress
        emailTextField.delegate = self
    }
    
    func configureCustomViews() {
        view.addSubviews(emailTextField, passwordTextField, enterButton)
        
        makeSidesPadding(items: emailTextField, passwordTextField, enterButton, padding: 20)
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            emailTextField.heightAnchor.constraint(equalToConstant: 45),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            
            enterButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            enterButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        enterButton.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
    }
    
// MARK: - Firebase Login and Sign Up Functions
    
    @objc func enterButtonPressed() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        
        switch authenticationType {
        case .login:
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
                guard let self else { return }
                guard error == nil else {
                    return
                }
                self.enterSuccessfuly()
            }
            
        case .signup:
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                guard let self else { return }
                guard error == nil else {
                    return
                }
                self.enterSuccessfuly()
            }
            
        case .none:
            return
        }
    }
    
    func enterSuccessfuly() {
        let tabbar = IspTabbarController()
        
        tabbar.modalPresentationStyle = .fullScreen
        tabbar.modalTransitionStyle = .crossDissolve
        present(tabbar, animated: true)
    }
}

// MARK: - Configure Keyboard

extension AuthenticationVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enterButtonPressed()
        return true
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}
