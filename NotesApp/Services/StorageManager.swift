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
        try! realm.write {
            realm.add(note)
        }
    }
    
}
