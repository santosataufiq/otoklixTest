//
//  PostCell.swift
//  otoklix
//
//  Created by harrie yusuf on 22/01/22.
//

import Foundation
import UIKit

final class PostCell: UITableViewCell {
    static let identifier = "PostCell"
    var removeCell: (() -> Void)?
    private let viewModel = PostCellViewModel(deletePost: DeletePostImp())
    
    
    private let titleLabel = UILabel()
    private let contentLabel = UITextView()
    private let buttonDelete = UIButton()
    private var postId: Int = 0
    
    override func prepareForReuse() {
        super.prepareForReuse()
        buttonDelete.setTitle("Delete", for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configureView()
        viewModel.state.listen { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.buttonDelete.setTitle("Deleting...", for: .normal)
            case .success(()):
                self.removeCell?()
            case .error:
                self.buttonDelete.setTitle("Deleting fail, try again?", for: .normal)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(title: String, content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }
    
    func set(postId: Int) {
        self.postId = postId
    }
    
    private func configureView() {
        configureTitleLabel()
        configureContentLabel()
        configureButton()
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 20)
        ])
    }
    
    private func configureContentLabel() {
        addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.isScrollEnabled = false
        contentLabel.textContainerInset = .zero
        contentLabel.textContainer.lineFragmentPadding = .zero
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            contentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.rightAnchor.constraint(equalTo: contentLabel.rightAnchor, constant: 20)
        ])
    }
    
    private func configureButton() {
        addSubview(buttonDelete)
        buttonDelete.translatesAutoresizingMaskIntoConstraints = false
        buttonDelete.setTitle("Delete", for: .normal)
        buttonDelete.titleLabel?.textColor = .white
        buttonDelete.backgroundColor = .red
        buttonDelete.addTarget(self, action: #selector(pressButtonDelete), for: .touchUpInside)
        NSLayoutConstraint.activate([
            buttonDelete.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            buttonDelete.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 8),
            buttonDelete.heightAnchor.constraint(equalToConstant: 24),
            self.trailingAnchor.constraint(equalTo: buttonDelete.trailingAnchor, constant: 20),
            self.bottomAnchor.constraint(equalTo: buttonDelete.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func pressButtonDelete() {
        viewModel.delete(postId: postId)
    }
}
