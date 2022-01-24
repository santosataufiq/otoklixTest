//
//  DeletePostStub.swift
//  otoklixTests
//
//  Created by harrie yusuf on 24/01/22.
//

@testable import otoklix

final class DeletePostStub: DeletePostUseCase {
    var returnResult = false
    var isSuccess = false
    
    func delete(id: Int, result: @escaping ((Result<Void>) -> Void)) {
        if returnResult {
            if isSuccess {
                result(.success(()))
            } else {
                result(.fail)
            }
        }
    }
}
