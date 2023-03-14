//
//  IspiyonlaVC.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 13.03.2023.
//

import UIKit
import Firebase

class IspiyonlaVC: UIViewController {
    
    let vehicles = ["Otobüs", "Taksi", "Uber", "Şehirler Arası Otobüs"]
    let vehicleButton = IspButton(title: "Otobüs", backgroundColor: IspColors.buttonColor2)
    let vehiclePickerView = UIPickerView()
    
    let plaqueTextField = IspTextField(placeholder: "14B, 320 gibi")
    let complaintTextView = IspTextView()
    let complaintButton = IspButton(title: "ispikle", backgroundColor: IspColors.buttonColor1)
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyDefaultScreenSettings()
        addSignOutButtonToRight()
        configurePickerView()
        configureView()
        createDismissKeyboardTapGesture()
    }
    
    func configurePickerView() {
        vehiclePickerView.translatesAutoresizingMaskIntoConstraints = false
        vehiclePickerView.backgroundColor = IspColors.pickerViewColor
        vehiclePickerView.isHidden = true
        vehiclePickerView.delegate = self
        vehiclePickerView.dataSource = self
        vehiclePickerView.layer.cornerRadius = 10
    }
    
    func configureView() {
        view.addSubviews(vehicleButton, vehiclePickerView, plaqueTextField, complaintTextView, complaintButton)
        
        plaqueTextField.delegate = self
        complaintTextView.delegate = self
        
        makeSidesPadding(items: vehicleButton, vehiclePickerView, plaqueTextField, complaintTextView, complaintButton, padding: 20)
        
        NSLayoutConstraint.activate([
            vehicleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            vehicleButton.heightAnchor.constraint(equalToConstant: 50),
            
            vehiclePickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            vehiclePickerView.heightAnchor.constraint(equalToConstant: 100),
            
            plaqueTextField.topAnchor.constraint(equalTo: vehicleButton.bottomAnchor, constant: 10),
            plaqueTextField.heightAnchor.constraint(equalToConstant: 45),
            
            complaintTextView.topAnchor.constraint(equalTo: plaqueTextField.bottomAnchor, constant: 10),
            complaintTextView.heightAnchor.constraint(equalToConstant: 120),
            
            complaintButton.topAnchor.constraint(equalTo: complaintTextView.bottomAnchor, constant: 10),
            complaintButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        vehicleButton.addTarget(self, action: #selector(vehicleButtonPressed), for: .touchUpInside)
        complaintButton.addTarget(self, action: #selector(complaintButtonPressed), for: .touchUpInside)
    }
    
    @objc func vehicleButtonPressed() {
        view.endEditing(true)
        vehiclePickerView.isHidden = false
    }
    
    @objc func complaintButtonPressed() {
        guard let plaka = plaqueTextField.text, !plaka.isEmpty,
              let şikayet = complaintTextView.text, !şikayet.isEmpty else { return }
        let binek = vehicleButton.titleLabel!.text!
        let user = FirebaseAuth.Auth.auth().currentUser!.email!
        
        db.collection("ispiyon").addDocument(data: [
            "gönderen": user,
            "araç": binek,
            "plaka": plaka,
            "şikayet": şikayet,
            "zaman": Date().timeIntervalSince1970
        ])
        
        view.endEditing(true)
        plaqueTextField.text = ""
        complaintTextView.text = ""
    }
}

// MARK: - Configure PickerView

extension IspiyonlaVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = vehicles[row]
        let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return attributedString
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        vehicles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        vehicleButton.setTitle(vehicles[row], for: .normal)
        vehiclePickerView.isHidden = true
        
        switch vehicles[row] {
        case "Otobüs":
            plaqueTextField.placeholder = "14B, 320 gibi"
        case "Taksi":
            plaqueTextField.placeholder = "Plaka"
        case "Uber":
            plaqueTextField.placeholder = "Plaka"
        case "Şehirler Arası Otobüs":
            plaqueTextField.placeholder = "Şirket veya Plaka"
        default:
            print("aaa")
        }
    }
}

// MARK: - Configure TextFields

extension IspiyonlaVC: UITextFieldDelegate, UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        vehiclePickerView.isHidden = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        vehiclePickerView.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}
