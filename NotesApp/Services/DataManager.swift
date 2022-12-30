//
//  DataManager.swift
//  NotesApp
//
//  Created by Olga Yurchuk on 29.12.2022.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    func createInitialData(completion: @escaping () -> Void) {
        if !UserDefaults.standard.bool(forKey: "DoWeHaveData") {
            
            let note = Note()
            note.title = "Hello"
            note.text = "from Olga Yurchuk!"
                        
            DispatchQueue.main.async {
                StorageManager.shared.save(note)
                UserDefaults.standard.set(true, forKey: "DoWeHaveData")
                completion()
            }
        }
    }
}
