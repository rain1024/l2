//
//  ModelData.swift
//  l2
//
//  Created by Vu Anh on 20/05/2023.
//
import Foundation
import SQLite3

var stories: [Story] = load("stories.json")

var vocabs: [Vocab] = load("vocabs.json")

var languages: [Language] = load("languages.json")

let languageNames = languages.map { $0.name }

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) from main bundle:\n\(error)")
    }
}

let vocab1 = loadSQLite("./Data/database.sqlite3", tableName: "words")

func loadSQLite(_ filename: String, tableName: String) -> [Int] {
    
    let data: [Int]
    
//    do {
//        let db = try Connection(filename)
//    } catch {
//        print(error)
//    }
    
    data = [1]
    
    return data
}



extension UserDefaults {
    func storeObject<T: Codable>(_ object: T, key: String) {
        do {
            let data = try JSONEncoder().encode(object)
            UserDefaults.standard.set(data, forKey: key)
        } catch let error {
            print("Error encoding: \(error)")
        }
    }
    
    func getObject<T: Codable>(for key: String) -> T? {
        do {
            guard let data = UserDefaults.standard.data(forKey: key) else {
                return nil
            }
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            print("Error decoding: \(error)")
            return nil
        }
    }
}
