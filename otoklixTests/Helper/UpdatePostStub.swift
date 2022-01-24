//
//  UpdatePostUpdate.swift
//  otoklixTests
//
//  Created by harrie yusuf on 23/01/22.
//

@testable import otoklix

final class UpdatePostStub: UpdatePostUseCase {
    var returnResult = false
    var mockedPost: Post?
    
    func update(id: Int, params: [String : String], result: @escaping ((Result<Post>) -> Void)) {
        if returnResult {
            if let mockedPost = mockedPost {
                result(.success(mockedPost))
            } else {
                result(.fail)
            }
        }
    }
}
