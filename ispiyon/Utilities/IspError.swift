//
//  IspError.swift
//  ispiyon
//
//  Created by Muhammed Emin Bardakcı on 19.05.2023.
//

import Foundation

enum IspError: String, Error {
    case takeAllDataError = "Veriler alınırken bir hata oluştu."
    case signInError = "Giriş yapılırken bir hata oluştu lütfen tekrar deneyiniz"
    case userError = "Kullanıcı bulunurken bir hata oluştu lütfen tekrar deneyiniz"
}
