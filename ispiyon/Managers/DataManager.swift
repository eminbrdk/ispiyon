//
//  DataManager.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 19.05.2023.
//

import UIKit
import Firebase

class DataManager {
    
    static let shared = DataManager()
    private let db = Firestore.firestore()
    
    func addİspiyon(user: String, binek: String, plaka: String, şikayet: String) {
        db.collection("ispiyon").addDocument(data: [
            "gönderen": user,
            "araç": binek,
            "plaka": plaka,
            "şikayet": şikayet,
            "zaman": Date().timeIntervalSince1970
        ])
    }
    
    func takeAllData(completed: @escaping (Result<QuerySnapshot, IspError>) -> Void) {
        db.collection("ispiyon").order(by: "zaman", descending: true).addSnapshotListener { querySnapshot, error in
            guard let querySnapshot, error == nil else {
                completed(.failure(.takeAllDataError))
                return
            }
            
            completed(.success(querySnapshot))
        }
    }
}
