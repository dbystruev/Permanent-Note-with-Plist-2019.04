//
//  Note.swift
//  Permanent Note
//
//  Created by Denis Bystruev on 15/04/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import Foundation

struct Note: Codable {
    let title: String
    let text: String
    let timestamp: Date
    
    var encoded: Data? {
        let encoder = PropertyListEncoder()
        
        return try? encoder.encode(self)
    }
    
    static func loadSample() -> [Note] {
        return [
            Note(title: "Купить вина", text: "Белого", timestamp: Date()),
            Note(title: "День рождения", text: "Васи", timestamp: Date().addingTimeInterval(60 * 60 * 24)),
            Note(title: "Зайти в булочную", text: "Сегодня вечером", timestamp: Date())
        ]
    }
}

extension Note {
    init?(from data: Data) {
        let decoder = PropertyListDecoder()
        
        guard let newNote = try? decoder.decode(Note.self, from: data) else { return nil }
        
        title = newNote.title
        text = newNote.text
        timestamp = newNote.timestamp
    }
}

extension Array where Element == Note {
    var encoded: Data? {
        let encoder = PropertyListEncoder()
        
        return try? encoder.encode(self)
    }
    
    init?(from data: Data) {
        let decoder = PropertyListDecoder()
        
        guard let decodedNotes = try? decoder.decode([Note].self, from: data) else { return nil }
        
        self = decodedNotes
    }
}
