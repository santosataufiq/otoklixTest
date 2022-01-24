//
//  Constant.swift
//  otoklix
//
//  Created by harrie yusuf on 22/01/22.
//

import Foundation

typealias CellUpdater = ((_ id: Int, _ title: String, _ content: String) -> Void)

struct Constant {
    private init() { }
    
    static let id = "id"
    static let title = "title"
    static let content = "content"
}
