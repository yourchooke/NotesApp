//
//  Note.swift
//  NotesApp
//
//  Created by Olga Yurchuk on 29.12.2022.
//

import RealmSwift
import Foundation

class Note: Object {
    @Persisted var title = ""
    @Persisted var text = ""
    @Persisted var date = Date()
}
