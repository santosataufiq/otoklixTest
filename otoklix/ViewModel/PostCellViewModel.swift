//
//  DeletePostViewModel.swift
//  otoklix
//
//  Created by harrie yusuf on 23/01/22.
//

import Foundation

final class PostCellViewModel: WithState {
    typealias GenericState = State
    private let deletePost: DeletePostUseCase
    
    enum State: Equatable {
        case loading
        case success(Void)
        case error
        
        static func == (lhs: PostCellViewModel.State, rhs: PostCellViewModel.State) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading):
                return true
            case (.error, .error):
                return true
            case (.success(()), .success(())):
                return true
            default:
                return false
            }
        }
    }
    
    init(deletePost: DeletePostUseCase) {
        self.deletePost = deletePost
    }
    
    var state = Object<State>()
    
    func delete(postId: Int) {
        state.change(.loading)
        
        deletePost.delete(id: postId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .fail:
                self.state.change(.error)
            case .success(_):
                self.state.change(.success(()))
            }
        }
    }
}
