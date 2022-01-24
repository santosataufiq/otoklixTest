//
//  PostDetailViewController.swift
//  otoklix
//
//  Created by harrie yusuf on 22/01/22.
//

import Foundation
import UIKit

final class PostDetailViewController: UIViewController {
    private let titleField = UITextField()
    private let contentField = UITextView()
    private let updateInfo = UpdateInfo()
    
    private let viewModel = PostDetailViewModel(updatePost: UpdatePostImp())
    private var cellUpdater: CellUpdater?
    
    override func viewDidLoad() {
        view.backgroundColor = .lightGray
        configureView()
    }
    
    func set(postId: Int,
             title: String,
             content: String,
             cellUpdater: CellUpdater?) {
        viewModel.postId = postId
        titleField.text = title
        contentField.text = content
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
        view.addSubview(updateInfo)
        updateInfo.set(vm: viewModel)
        updateInfo.translatesAutoresizingMaskIntoConstraints = false
        updateInfo.buttonPressed = { [unowned self] in
            self.viewModel.update(title: titleField.text ?? "",
                                  content: contentField.text ?? "")
        }
        updateInfo.successUpdateInfo = { [unowned self] post in
            self.cellUpdater?(post.id, post.title, post.content)
        }
        
        NSLayoutConstraint.activate([
            updateInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            updateInfo.topAnchor.constraint(equalTo: contentField.bottomAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: updateInfo.trailingAnchor, constant: 20),
            view.bottomAnchor.constraint(equalTo: updateInfo.bottomAnchor, constant: 100)
        ])
    }
}
