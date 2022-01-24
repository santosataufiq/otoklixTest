//
//  AddPostStub.swift
//  otoklixTests
//
//  Created by harrie yusuf on 24/01/22.
//

@testable import otoklix

final class AddPostStub: AddPostUseCase {
    var returnResult = false
    var mockedPost: Post?
    
    func addPost(params: [String : String], result: @escaping ((Result<Post>) -> Void)) {
        if returnResult {
            if let mockedPost = mockedPost {
                result(.success(mockedPost))
            } else {
                result(.fail)
            }
        }
    }
}
