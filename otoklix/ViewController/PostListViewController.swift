//
//  ViewController.swift
//  otoklix
//
//  Created by harrie yusuf on 22/01/22.
//

import UIKit

final class PostListViewController: UIViewController {

    private let viewModel = PostListViewModel(loadPost: LoadPostImp())
    private let postList = PostList()
    private let buttonAdd = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.state.listen { [unowned self] state in
            switch state {
            case.error:
                postList.backgroundView = nil
            case .loading:
                let loading = UIActivityIndicatorView()
                loading.startAnimating()
                postList.backgroundView = loading
            case .show(let posts):
                postList.backgroundView = nil
                self.postList.set(postData:
                                    posts.map {[
                                        Constant.id: $0.id,
                                        Constant.title: $0.title,
                                        Constant.content: $0.content]
                                    }
                )
                self.postList.reloadData()
            }
        }
        viewModel.load()
    }
    
    private func configureView() {
        view.backgroundColor = .lightText
        configureButtonAdd()
        configurePostList()
    }
    
    private func configureButtonAdd() {
        view.addSubview(buttonAdd)
        buttonAdd.translatesAutoresizingMaskIntoConstraints = false
        buttonAdd.backgroundColor = .cyan
        buttonAdd.setTitle("Add Post", for: .normal)
        buttonAdd.setTitleColor(.black, for: .normal)
        buttonAdd.addTarget(self, action: #selector(pushToAddPostVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            buttonAdd.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            buttonAdd.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: buttonAdd.trailingAnchor, constant: 20),
            buttonAdd.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configurePostList() {
        view.addSubview(postList)
        postList.translatesAutoresizingMaskIntoConstraints = false
        postList.set { [unowned self] row, postData in
            let vc = PostDetailViewController()
            vc.set(postId: postData[Constant.id] as? Int ?? 0,
                   title: postData[Constant.title] as? String ?? "",
                   content: postData[Constant.content] as? String ?? "")
            { id, title, content in
                postList.updateData(at: row,
                                    data: [Constant.id: id,
                                           Constant.title: title,
                                           Constant.content: content])
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        NSLayoutConstraint.activate([
            postList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postList.topAnchor.constraint(equalTo: buttonAdd.bottomAnchor, constant: 20),
            view.trailingAnchor.constraint(equalTo: postList.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: postList.bottomAnchor)
        ])
    }
    
    @objc private func pushToAddPostVC() {
        let vc = PostAddViewController()
        vc.set { [unowned self] id, title, content in
            self.postList.addData(data: [Constant.id: id,
                                         Constant.title: title,
                                         Constant.content: content])
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

