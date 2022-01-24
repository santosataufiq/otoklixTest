//
//  PostList.swift
//  otoklix
//
//  Created by harrie yusuf on 22/01/22.
//

import Foundation
import UIKit

class PostList: UITableView {
    private let handler = PostListHandler()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        delegate = handler
        dataSource = handler
        handler.removeRow = { [unowned self]  in
            reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(postData: [[String: Any]]) {
        handler.postData = postData
    }
    
    func set(selectData: ((Int, [String: Any]) -> ())?) {
        handler.selectData = selectData
    }
    
    func updateData(at row: Int, data: [String: Any]) {
        handler.updateData(at: row, data: data)
        reloadRows(at: [IndexPath(row: row, section: 0)],
                   with: .none)
    }
    
    func addData(data: [String: Any]) {
        handler.postData.insert(data, at: 0)
        reloadData()
    }
}

fileprivate class PostListHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    var postData: [[String: Any]] = []
    var selectData: ((Int, [String: Any]) -> ())?
    var removeRow: (() -> Void)?
    
    func updateData(at row: Int, data: [String: Any]) {
        guard row < postData.count else {
            return
        }
        
        postData[row][Constant.title] = data[Constant.title]
        postData[row][Constant.content] = data[Constant.content]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < postData.count else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier) as! PostCell
        cell.contentView.isUserInteractionEnabled = false
        let data = postData[indexPath.row]
        cell.set(title: data[Constant.title] as? String ?? "",
                 content: data[Constant.content] as? String ?? "")
        cell.removeCell = { [unowned self] in
            postData.remove(at: indexPath.row)
            removeRow?()
        }
        cell.set(postId: data[Constant.id] as? Int ?? 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < postData.count else {
            return
        }
        
        selectData?(indexPath.row, postData[indexPath.row])
    }
}
