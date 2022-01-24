//
//  PostAddViewModel.swift
//  otoklix
//
//  Created by harrie yusuf on 24/01/22.
//

import Foundation

final class PostAddViewModel: WithState {
    typealias GenericState = State
    private let addPost: AddPostUseCase
    
    enum State: Equatable {
        case loading
        case success(Post)
        case error
    }
    
    init(addPost: AddPostUseCase) {
        self.addPost = addPost
    }
    
    var state = Object<State>()
    
    func addPostWith(title: String, content: String) {
        state.change(.loading)
        let params = [Constant.title: title, Constant.content: content]
        
        addPost.addPost(params: params) { [weak self] result in
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
