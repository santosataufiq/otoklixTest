//
//  Post.swift
//  otoklix
//
//  Created by harrie yusuf on 22/01/22.
//

import Foundation

struct Post: Codable, Equatable {
    let id: Int
    let title: String
    let content: String
    
    init(id: Int, title: String, content: String) {
        self.id = id
        self.title = title
        self.content = content
    }
}
