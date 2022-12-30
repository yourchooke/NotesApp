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
        createTempData()
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
        content.secondaryText = note.text
        cell.contentConfiguration = content
        return cell
    }
    
    // Navigation in Table view
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let note = noteList[indexPath.row]
        let editAction = UIContextualAction(
            style: .normal,
            title: "Edit") { _, _, isDone in
                self.openEditor(for: note)
                isDone(true)
            }
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "Delete") { _, _, _ in
                StorageManager.shared.delete(note)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }

    private func setupNavigationBar() {
        title = "Notes"
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = .systemBrown
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        
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
    
    private func createTempData() {
        DataManager.shared.createInitialData{
            self.tableView.reloadData()
        }
    }
    
    @objc private func addNewNote() {
        let noteVC = NoteEditorViewController()
        navigationController?.pushViewController(noteVC, animated: true)
    }

    private func openEditor(for note: Note?){
        let noteVC = NoteEditorViewController()
        noteVC.note = note
        navigationController?.pushViewController(noteVC, animated: true)
    }
    
}

