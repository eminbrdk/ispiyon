//
//  IspiyonlarVC.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 13.03.2023.
//

import UIKit
import Firebase

class ComplaintsVC: UIViewController {
    
    var complaints: [[String: Any]] = []
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        takeData()
    }
    
    private func configureView() {
        title = "ispiyonlar"
        applyDefaultScreenSettings()
        addSignOutButtonToRight()
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.backgroundColor = .systemBackground
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight =  160
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        
        tableView.register(SikayetCell.self, forCellReuseIdentifier: SikayetCell.reuseID)
    }
    
    private func takeData() {
        DataManager.shared.takeAllData { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .failure(let err):
                self.presentIspAlert(title: "Upss", message: err.rawValue, buttonTitle: "Tamam")
                return
                
            case .success(let querySnapshot):
                self.complaints = []
                for documnet in querySnapshot.documents {
                    self.complaints.append(documnet.data())
                }
                self.tableView.reloadData()
            }
        }
    }
}

extension ComplaintsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return complaints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SikayetCell.reuseID, for: indexPath) as! SikayetCell
        let content = complaints[indexPath.row]
        cell.set(vehicleType: content["araç"] as! String, plaque: content["plaka"] as! String, user: content["gönderen"] as! String, complaint: content["şikayet"] as! String)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = complaints[indexPath.row]
        let ispiyonVC = ComplaintVC()
        ispiyonVC.title = "ispiyon"
        ispiyonVC.set(vehicleType: content["araç"] as! String, plaque: content["plaka"] as! String, user: content["gönderen"] as! String, complaint: content["şikayet"] as! String)
        
        navigationController?.pushViewController(ispiyonVC, animated: true)
    }
}
