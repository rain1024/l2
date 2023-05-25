//
//  Word.swift
//  l2
//
//  Created by Vu Anh on 21/05/2023.
//

import Foundation

struct Vocab: Hashable, Codable {
    var text: String
    var lang: String
    var description: String?
    var topic: String?
}
