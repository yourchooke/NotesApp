//
//  StorageManager.swift
//  NotesApp
//
//  Created by Olga Yurchuk on 29.12.2022.
//

import RealmSwift

class StorageManager {
    static let shared = StorageManager()
    
    let realm = try! Realm()
    
    private init() {}
    
    func save(_ note: Note) {
        write {
            realm.add(note)
        }
    }
    
    func edit(_ note: Note, newTitle: String, newText: String) {
        write {
            note.title = newTitle
            note.text = newText
        }
    }
        
    func delete(_ note: Note) {
        write {
            realm.delete(note)
        }
    }

    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
    
}
