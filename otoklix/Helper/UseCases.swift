//
//  UseCases.swift
//  otoklix
//
//  Created by harrie yusuf on 22/01/22.
//

import Foundation

enum Result<T> {
    case success(T)
    case fail
}

protocol LoadPostUseCase {
    func load(result: @escaping ((Result<[Post]>) -> Void))
}

protocol UpdatePostUseCase {
    func update(id: Int, params: [String: String], result: @escaping ((Result<Post>) -> Void))
}

protocol DeletePostUseCase {
    func delete(id: Int, result: @escaping ((Result<Void>) -> Void))
}

protocol AddPostUseCase {
    func addPost(params: [String: String], result: @escaping((Result<Post>) -> Void))
}
