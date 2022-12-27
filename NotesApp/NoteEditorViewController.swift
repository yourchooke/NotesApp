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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews(titleField)
        setConstraints()
    }
    
    private func setupSubviews(_ subviews: UIView...){
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraints() {
        titleField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

}
