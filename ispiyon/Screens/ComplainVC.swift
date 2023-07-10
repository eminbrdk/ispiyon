//
//  IspiyonlaVC.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 13.03.2023.
//

import UIKit
import Firebase

class ComplainVC: UIViewController {
    
    let userName = Auth.auth().currentUser!.email
    let vehicles = ["Otobüs", "Taksi", "Uber", "Şehirler Arası Otobüs"]
    let vehicleButton = IspButton(title: "Otobüs", backgroundColor: IspColors.buttonColor2)
    let vehiclePickerView = UIPickerView()
    
    let plaqueTextField = IspTextField(placeholder: "14B, 320 gibi")
    let complaintTextView = IspTextView()
    let complaintButton = IspButton(title: "ispikle", backgroundColor: IspColors.buttonColor1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        giveInfoAboutComplaining()
        configurePickerView()
        configureCustomViews()
        createDismissKeyboardTapGesture()
    }
    
    private func configureView() {
        title = "ispiyonla"
        applyDefaultScreenSettings()
        addSignOutButtonToRight()
    }
    
    private func giveInfoAboutComplaining() {
        presentIspAlert(title: "Hey", message: "Otobüs yazan butona tıklayıp şikayet etmek istediğiniz araç türünü seçin ve şikayetinizi yapın :)", buttonTitle: "Tamam")
    }
    
    private func configurePickerView() {
        vehiclePickerView.translatesAutoresizingMaskIntoConstraints = false
        vehiclePickerView.backgroundColor = .systemGray6
        vehiclePickerView.isHidden = true
        vehiclePickerView.delegate = self
        vehiclePickerView.dataSource = self
    }
    
    private func configureCustomViews() {
        view.addSubviews(vehicleButton, vehiclePickerView, plaqueTextField, complaintTextView, complaintButton)
        
        plaqueTextField.delegate = self
        
        complaintTextView.delegate = self
        complaintTextView.text = "Lütfen şikayetinizi buraya girin"
        complaintTextView.textColor = .systemGray
        
        view.makeSidesPadding(items: vehicleButton, plaqueTextField, complaintTextView, complaintButton, padding: 20)
        view.makeSidesPadding(items: vehiclePickerView, padding: 0)
        
        NSLayoutConstraint.activate([
            vehicleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            vehicleButton.heightAnchor.constraint(equalToConstant: 50),
            
            plaqueTextField.topAnchor.constraint(equalTo: vehicleButton.bottomAnchor, constant: 10),
            plaqueTextField.heightAnchor.constraint(equalToConstant: 45),
            
            complaintTextView.topAnchor.constraint(equalTo: plaqueTextField.bottomAnchor, constant: 10),
            complaintTextView.heightAnchor.constraint(equalToConstant: 120),
            
            complaintButton.topAnchor.constraint(equalTo: complaintTextView.bottomAnchor, constant: 10),
            complaintButton.heightAnchor.constraint(equalToConstant: 50),
            
            vehiclePickerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            vehiclePickerView.heightAnchor.constraint(equalToConstant: 150),
        ])
        
        vehicleButton.addTarget(self, action: #selector(vehicleButtonPressed), for: .touchUpInside)
        complaintButton.addTarget(self, action: #selector(complaintButtonPressed), for: .touchUpInside)
    }
    
    @objc private func vehicleButtonPressed() {
        view.endEditing(true)
        vehiclePickerView.isHidden = false
    }
    
    @objc private func complaintButtonPressed() {
        guard let plaka = plaqueTextField.text, !plaka.isEmpty,
              let şikayet = complaintTextView.text, !şikayet.isEmpty, şikayet != "Lütfen şikayetinizi buraya girin" else {
            presentIspAlert(title: "Upss", message: "Lütfen tüm boşlukları doldurunuz", buttonTitle: "Tamam")
            return
        }
        let binek = vehicleButton.titleLabel!.text!
        
        DataManager.shared.addİspiyon(user: userName!, binek: binek, plaka: plaka, şikayet: şikayet)
        
        view.endEditing(true)
        plaqueTextField.text = ""
        complaintTextView.text = "Lütfen şikayetinizi buraya girin"
        complaintTextView.textColor = .systemGray
        self.presentIspAlert(title: "İspikledin", message: "Şikayetiniz yapılmıştır. İspiyonlar sayfasından şikayetleri görebilirsiniz.", buttonTitle: "Tamam")
    }
}

// MARK: - Configure PickerView

extension ComplainVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = vehicles[row]
        let attributedString = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor : UIColor.label])
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

extension ComplainVC: UITextFieldDelegate, UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        vehiclePickerView.isHidden = true
        
        if textView.textColor == UIColor.systemGray {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Lütfen şikayetinizi buraya girin"
            textView.textColor = UIColor.systemGray
        }
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
