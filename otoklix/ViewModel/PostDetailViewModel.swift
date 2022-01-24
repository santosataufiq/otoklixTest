//
//  UpdatePostViewModel.swift
//  otoklix
//
//  Created by harrie yusuf on 23/01/22.
//

import Foundation

final class PostDetailViewModel: WithState {
    typealias GenericState = State
    private let updatePost: UpdatePostUseCase
    
    var postId = 0
    
    enum State: Equatable {
        case loading
        case success(Post)
        case error
    }
    
    init(updatePost: UpdatePostUseCase) {
        self.updatePost = updatePost
    }
    
    var state = Object<State>()
    
    func update(title: String, content: String) {
        state.change(.loading)
        let params = [Constant.title: title, Constant.content: content]
        
        updatePost.update(id: postId, params: params) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .fail:
                self.state.change(.error)
            case .success(let post):
                self.state.change(.success(post))
            }
        }
    }
}
