//
//  NoteEditorViewController.swift
//  NotesApp
//
//  Created by Olga Yurchuk on 28.12.2022.
//

import UIKit

class NoteEditorViewController: UIViewController {
    private lazy var titleField: UITextField = {
        let titleTextField = UITextField()
        titleTextField.placeholder = "Title"
        titleTextField.borderStyle = .roundedRect
        return titleTextField
    }()
    
    private lazy var noteTextView: UITextView = {
        let noteTextView = UITextView()
        noteTextView.text = "Description"
        noteTextView.allowsEditingTextAttributes = true
        return noteTextView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews(titleField, noteTextView)
        setConstraints()
    }
    
    private func setupSubviews(_ subviews: UIView...){
        subviews.forEach {subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        titleField.translatesAutoresizingMaskIntoConstraints = false
        noteTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            noteTextView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 10),
            noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noteTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
    

}
