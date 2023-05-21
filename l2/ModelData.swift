//
//  ModelData.swift
//  l2
//
//  Created by Vu Anh on 20/05/2023.
//

import Foundation

//var stories = [
//    "Chú cuội",
//    "Quê hương",
//    "Học đếm"
//]

var stories: [Story] = load("stories.json")

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
