//
//  Country.swift
//  API
//
//  Created by Doaa on 20/02/2024.
//

import Foundation

struct Country : Codable {
    var name : Name?
    var capital : [String]?
    var region : String?
}


// MARK: - Name
struct Name: Codable {
    let common, official: String
    let nativeName: NativeName
}

struct NativeName: Codable {
    let eng: Translation
}

// MARK: - Translation
struct Translation: Codable {
    let official, common: String
}




