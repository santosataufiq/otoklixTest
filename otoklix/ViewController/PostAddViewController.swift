//
//  PostAddViewController.swift
//  otoklix
//
//  Created by harrie yusuf on 24/01/22.
//

import Foundation
import UIKit

final class PostAddViewController: UIViewController {
    private let titleField = UITextField()
    private let contentField = UITextView()
    private let addInfo = AddInfo()
    
    private let viewModel = PostAddViewModel(addPost: AddPostImp())
    private var cellUpdater: CellUpdater?
    
    override func viewDidLoad() {
        view.backgroundColor = .lightGray
        configureView()
    }
    
    func set(cellUpdater: CellUpdater?) {
        self.cellUpdater = cellUpdater
    }
    
    private func configureView() {
        configureTitleField()
        configureContentField()
        configureUpdateInfo()
    }
    
    private func configureTitleField() {
        view.addSubview(titleField)
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.borderStyle = .line
        titleField.backgroundColor = .white
        NSLayoutConstraint.activate([
            titleField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleField.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            view.trailingAnchor.constraint(equalTo: titleField.trailingAnchor, constant: 20)
        ])
    }
    
    private func configureContentField() {
        view.addSubview(contentField)
        contentField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: contentField.trailingAnchor, constant: 20)
        ])
    }
    
    private func configureUpdateInfo() {
        view.addSubview(addInfo)
        addInfo.set(vm: viewModel)
        addInfo.translatesAutoresizingMaskIntoConstraints = false
        addInfo.buttonPressed = { [unowned self] in
            self.viewModel.addPostWith(title: titleField.text ?? "",
                                       content: contentField.text ?? "")
        }
        
        addInfo.successAddInfo = { [unowned self] post in
            self.cellUpdater?(post.id, post.title, post.content)
        }
        
        NSLayoutConstraint.activate([
            addInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addInfo.topAnchor.constraint(equalTo: contentField.bottomAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: addInfo.trailingAnchor, constant: 20),
            view.bottomAnchor.constraint(equalTo: addInfo.bottomAnchor, constant: 100)
        ])
    }

}
