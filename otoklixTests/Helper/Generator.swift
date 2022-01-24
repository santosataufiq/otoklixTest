//
//  File.swift
//  otoklixTests
//
//  Created by harrie yusuf on 22/01/22.
//

import Foundation
@testable import otoklix

final class Generator {
    private let books: [String] = ["The",
                                   "quick",
                                   "brown",
                                   "fox",
                                   "jumps",
                                   "over",
                                   "the",
                                   "lazy",
                                   "dog"]
    
    func number() -> Int {
        Int.random(in: 1...10)
    }
    
    func word() -> String {
        books.randomElement() ?? "trust"
    }
    
    func words() -> String {
        books.joined(separator: " ")
    }
    
    func post() -> Post {
        Post(id: number(),
             title: word(),
             content: words())
    }
    
    func posts(count: Int) -> [Post] {
        var posts: [Post] = []
        for _ in 0..<count {
            posts.append(post())
        }
        
        return posts
    }
}
