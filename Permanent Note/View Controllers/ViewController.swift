//
//  ViewController.swift
//  Permanent Note
//
//  Created by Denis Bystruev on 15/04/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var notes = Note.loadSample()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let encodedNotes = notes.encoded {
            print(#line, #function, encodedNotes)
            
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let archiveURL = documentDirectory.appendingPathComponent("notes_test").appendingPathExtension("plist")
            print(#line, #function, "url:", archiveURL.absoluteString)
            
            try? encodedNotes.write(to: archiveURL, options: .noFileProtection)
            
            if let data = try? Data(contentsOf: archiveURL) {
                if let decodedNotes = [Note](from: data) {
                    print(#line, #function, decodedNotes)
                }
            }
            
        }
        
    }


}

