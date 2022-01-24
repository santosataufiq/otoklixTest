//
//  PostViewModel.swift
//  otoklix
//
//  Created by harrie yusuf on 22/01/22.
//

import Foundation

class PostListViewModel: WithState {
    typealias GenericState = State
    
    enum State: Equatable {
        case loading
        case error
        case show([Post])
    }
    
    var state = Object<State>()
    private let loadPost: LoadPostUseCase
    
    init(loadPost: LoadPostUseCase) {
        self.loadPost = loadPost
    }
    
    func load() {
        state.change(.loading)
        loadPost.load { [unowned self] result in
            switch result {
            case .fail:
                self.state.change(.error)
            case .success(let posts):
                self.state.change(.show(posts))
            }
        }
    }
}
