//
//  NoteEditorViewController.swift
//  NotesApp
//
//  Created by Olga Yurchuk on 28.12.2022.
//

import UIKit

class NoteEditorViewController: UIViewController {
    
    var note: Note?
    
    private lazy var titleField: UITextField = {
        let titleTextField = UITextField()
        titleTextField.text = note?.title ?? "Title"
        titleTextField.borderStyle = .roundedRect
        titleTextField.font = .systemFont(ofSize: 18)
        return titleTextField
    }()
    
    private lazy var noteTextView: UITextView = {
        let noteTextView = UITextView()
        noteTextView.text = note?.text ?? "Description"
        noteTextView.allowsEditingTextAttributes = true
        noteTextView.font = .systemFont(ofSize: 16)
        return noteTextView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        view.backgroundColor = .white
        setupSubviews(titleField, noteTextView)
        setConstraints()
    }
    
    private func setupSubviews(_ subviews: UIView...){
        subviews.forEach {subview in
            view.addSubview(subview)
        }
    }
    
    // Bar button Items
    private func setupNavigationController(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backItem?.backBarButtonItem?.title = "Cancel"
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(done))
        
        let deleteButton = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: #selector(deleteNote))
        
        navigationItem.rightBarButtonItems = [doneButton, deleteButton]
    }
    
    private func setConstraints() {
        titleField.translatesAutoresizingMaskIntoConstraints = false
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            noteTextView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 10),
            noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noteTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
        ])
    }
    
    @objc private func done() {
        if let note = note {
            StorageManager.shared.edit(note, newTitle: titleField.text ?? "", newText: noteTextView.text ?? "")
        } else {
            let newNote = Note(value: [titleField.text ?? "", noteTextView.text ?? ""])
            StorageManager.shared.save(newNote)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func deleteNote() {
        if let note = note {
            StorageManager.shared.delete(note)
        }
        navigationController?.popViewController(animated: true)
    }

}
