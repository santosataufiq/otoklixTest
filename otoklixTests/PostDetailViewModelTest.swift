//
//  UpdatePostViewModelTest.swift
//  otoklixTests
//
//  Created by harrie yusuf on 23/01/22.
//

import XCTest
@testable import otoklix

final class PostDetailViewModelTest: XCTestCase {
    var updatePostStub: UpdatePostStub!
    var sut: PostDetailViewModel!
    var stateReader: StateReader<PostDetailViewModel>!
    let generator = Generator()
    
    override func setUp() {
        updatePostStub = UpdatePostStub()
        sut = PostDetailViewModel(updatePost: updatePostStub)
        stateReader = StateReader(sut)
    }
    
    func testLoadingState() {
        sut.update(title: "", content: "")
        
        XCTAssertEqual(stateReader.states, [.loading])
    }
    
    func testUpdateSuccess() {
        let randomPost = generator.post()
        updatePostStub.returnResult = true
        updatePostStub.mockedPost = randomPost
        
        sut.update(title: "", content: "")
        
        XCTAssertEqual(stateReader.states, [.loading, .success(randomPost)])
    }
    
    func testUpdateFail() {
        updatePostStub.returnResult = true
        
        sut.update(title: "", content: "")
        
        XCTAssertEqual(stateReader.states, [.loading, .error])
    }
}
