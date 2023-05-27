//
//  Phonetic.swift
//  l2
//
//  Created by Vu Anh on 26/05/2023.
//

import Foundation

struct Phonetic: Hashable, Decodable {
    var name: String
    var symbol: String
    var sound: String
    var examples: [PhoneticExample] = []
    
    enum CodingKeys: String, CodingKey {
        case name, symbol, sound, examples
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        symbol = try container.decode(String.self, forKey: .symbol)
        sound = try container.decode(String.self, forKey: .sound)
        examples = (try? container.decode([PhoneticExample].self, forKey: .examples)) ?? []
    }
    
    init(name: String, symbol: String, sound: String, examples: [PhoneticExample]? = nil) {
        self.name = name
        self.symbol = symbol
        self.sound = sound
        self.examples = examples ?? []
    }
}

struct PhoneticExample: Hashable, Decodable {
    var ipa: String
    var word: String
    var description: String
    var sound: String
    var sound2: String?
}

