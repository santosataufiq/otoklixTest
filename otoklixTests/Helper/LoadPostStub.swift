//
//  LoadPostStub.swift
//  otoklixTests
//
//  Created by harrie yusuf on 22/01/22.
//

import Foundation
@testable import otoklix

final class LoadPostStub: LoadPostUseCase {
    var posts: [Post] = []
    var returnResult = false
    
    func load(result: @escaping ((Result<[Post]>) -> Void)) {
        if returnResult {
            if !posts.isEmpty {
                result(.success(posts))
            } else {
                result(.fail)
            }
        }
    }
}
