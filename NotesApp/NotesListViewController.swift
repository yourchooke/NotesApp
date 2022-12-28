//
//  ViewController.swift
//  NotesApp
//
//  Created by Olga Yurchuk on 27.12.2022.
//

import UIKit
import RealmSwift

class NotesListViewController: UITableViewController {
    
    private let cellID = "note"
    private var noteList: Results<Note>!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        noteList = StorageManager.shared.realm.objects(Note.self)
        
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // Table view settings
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noteList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let note = noteList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = note.title
        cell.contentConfiguration = content
        return cell
    }

    private func setupNavigationBar() {
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = .systemBrown
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Add buttons to navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewNote)
        )
        
        navigationController?.navigationBar.tintColor = .white
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    @objc private func addNewNote() {
        let noteVC = NoteEditorViewController()
        navigationController?.pushViewController(noteVC, animated: true)
    }
    
}

