//
//  UpdateInfo.swift
//  otoklix
//
//  Created by harrie yusuf on 22/01/22.
//

import UIKit

final class UpdateInfo: UIView {
    private let infoLabel = UILabel()
    private let button = UIButton()
    
    var buttonPressed: (() -> Void)?
    var successUpdateInfo: ((Post)-> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(vm: PostDetailViewModel) {
        vm.state.listen { [weak self] state in
            guard let self = self else { return }
            switch state {
            case.loading:
                self.button.isEnabled = false
                self.button.setTitle("Loading...", for: .normal)
                self.infoLabel.alpha = 100
                self.infoLabel.text = "Please Wait"
            case .success(let post):
                self.button.isEnabled = true
                self.button.setTitle("Update", for: .normal)
                self.infoLabel.text = "Success Update"
                UIView.animate(withDuration: 2) {
                    self.infoLabel.alpha = 0
                }
                self.successUpdateInfo?(post)
            case .error:
                self.button.isEnabled = true
                self.button.setTitle("Update", for: .normal)
                self.infoLabel.text = "Fail Update"
                UIView.animate(withDuration: 2) {
                    self.infoLabel.alpha = 0
                }
            }
        }
    }
    
    private func configureView() {
        configureInfoLabel()
        configureButton()
    }
    
    private func configureInfoLabel() {
        self.infoLabel.alpha = 0
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.text = "Please Wait"
        addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            infoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: infoLabel.trailingAnchor)
        ])
    }
    
    private func configureButton() {
        addSubview(button)
        button.backgroundColor = .blue
        button.setTitle("Update", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 4),
            self.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            button.heightAnchor.constraint(equalToConstant: 40),
            self.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: 12)
        ])
    }
    
    @objc private func pressButton() {
        buttonPressed?()
    }
}
