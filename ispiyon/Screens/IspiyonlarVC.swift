//
//  IspiyonlarVC.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 13.03.2023.
//

import UIKit
import Firebase

class IspiyonlarVC: UIViewController {
    
    var complaints: [[String: Any]] = []
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyDefaultScreenSettings()
        addSignOutButtonToRight()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        takeData()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.backgroundColor = IspColors.viewBackgroundColor
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight =  150
        tableView.tableFooterView = UIView(frame: .zero)
        
        tableView.register(SikayetCell.self, forCellReuseIdentifier: SikayetCell.reuseID)
    }
    
    func takeData() {
        let db = Firestore.firestore()
        
        db.collection("ispiyon").order(by: "zaman", descending: true).addSnapshotListener { [weak self] querySnapshot, error in
            guard let self else { return }
            guard error == nil else { return }
            
            self.complaints = []
            for documnet in querySnapshot!.documents {
                self.complaints.append(documnet.data())
            }
        
            self.tableView.reloadData()
        }
    }
    
}

extension IspiyonlarVC: UITableViewDelegate, UITableViewDataSource {
    
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
        let ispiyonVC = IspiyonVC()
        ispiyonVC.title = "ispiyon"
        ispiyonVC.set(vehicleType: content["araç"] as! String, plaque: content["plaka"] as! String, user: content["gönderen"] as! String, complaint: content["şikayet"] as! String)
        
        navigationController?.pushViewController(ispiyonVC, animated: true)
    }
}
