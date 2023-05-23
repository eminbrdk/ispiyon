//
//  WelcomeVC.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 13.03.2023.
//

import UIKit
import Firebase
import GoogleSignIn

class WelcomeVC: UIViewController {

    let ispikİmage = UIImageView(image: UIImage(named: "ispik"))
    let welcomteText = IspTitleLabel()
    let loginButton = IspButton(title: "Google İle Giriş Yap", backgroundColor: IspColors.buttonColor1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpGoogle()
        configureView()
        configureCustomViews()
    }
    
    private func configureView() {
        title = "isp!k"
        applyDefaultScreenSettings()
    }
    
    private func setUpGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    }
    
    private func configureCustomViews() {
        view.addSubviews(ispikİmage, loginButton, welcomteText)
        
        ispikİmage.translatesAutoresizingMaskIntoConstraints = false
        ispikİmage.layer.cornerRadius = 10
        ispikİmage.clipsToBounds = true
        ispikİmage.contentMode = .scaleAspectFill
        
        welcomteText.numberOfLines = 0
        welcomteText.text = "İspiğe hoşgeldiniz\nToplu taşımalar ya da taksi gibi ulaşım için kullanılan araçlar hakkında şikayetlerinizi belirtin ve başka şikayetleri görün 🚎"
        welcomteText.textAlignment = .center
        
        loginButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        view.makeSidesPadding(items: ispikİmage, padding: 80)
        view.makeSidesPadding(items: loginButton, welcomteText, padding: 20)
        
        NSLayoutConstraint.activate([
            ispikİmage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            ispikİmage.heightAnchor.constraint(equalTo: ispikİmage.widthAnchor),
            
            welcomteText.topAnchor.constraint(equalTo: ispikİmage.bottomAnchor, constant: 30),
            welcomteText.heightAnchor.constraint(equalToConstant: 160),
            
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func buttonPressed(sender: UIButton!) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
            guard let self, error == nil else {
                self?.presentIspAlert(title: "Upss", message: IspError.signInError.rawValue, buttonTitle: "Tamam")
                return
            } 
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                self.presentIspAlert(title: "Upss", message: IspError.userError.rawValue, buttonTitle: "Tamam")
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            self.signInWithGoogle(credential: credential)
        }
    }
    
    private func signInWithGoogle(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { [weak self] data, err in
            guard let self, err == nil else {
                self?.presentIspAlert(title: "Upss", message: IspError.signInError.rawValue, buttonTitle: "Tamam")
                return
            }
            let tabbar = IspTabbarController()
            
            tabbar.modalPresentationStyle = .fullScreen
            tabbar.modalTransitionStyle = .crossDissolve
            self.present(tabbar, animated: true)
        }
    }
}
