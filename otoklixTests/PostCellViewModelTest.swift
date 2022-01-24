//
//  PostCellViewModelTest.swift
//  otoklixTests
//
//  Created by harrie yusuf on 24/01/22.
//

import XCTest
@testable import otoklix

final class PostCellViewModelTest: XCTestCase {
    var deletePostStub: DeletePostStub!
    var sut: PostCellViewModel!
    var stateReader: StateReader<PostCellViewModel>!
    let generator = Generator()
    
    override func setUp() {
        deletePostStub = DeletePostStub()
        sut = PostCellViewModel(deletePost: deletePostStub)
        stateReader = StateReader(sut)
    }
    
    func testLoadingState() {
        sut.delete(postId: 0)
        
        XCTAssertEqual(stateReader.states, [.loading])
    }
    
    func testUpdateSuccess() {
        deletePostStub.returnResult = true
        deletePostStub.isSuccess = true
        
        sut.delete(postId: 0)
        
        XCTAssertEqual(stateReader.states, [.loading, .success(())])
    }
    
    func testUpdateFail() {
        deletePostStub.returnResult = true
        deletePostStub.isSuccess = false
        
        sut.delete(postId: 0)
        
        XCTAssertEqual(stateReader.states, [.loading, .error])
    }
}
