//
//  Language.swift
//  l2
//
//  Created by Vu Anh on 21/05/2023.
//

import Foundation

struct Language: Hashable, Codable {
    var name: String
    var code: String
    var flag: String
}

let Vietnamese = Language(name: "Vietnamese", code: "vi", flag: "🇻🇳")
