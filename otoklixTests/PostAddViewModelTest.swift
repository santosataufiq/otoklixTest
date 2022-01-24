//
//  PostAddViewModelTest.swift
//  otoklixTests
//
//  Created by harrie yusuf on 24/01/22.
//

import XCTest
@testable import otoklix

final class PostAddViewModelTest: XCTestCase {
    var addPostStub: AddPostStub!
    var sut: PostAddViewModel!
    var stateReader: StateReader<PostAddViewModel>!
    let generator = Generator()
    
    override func setUp() {
        addPostStub = AddPostStub()
        sut = PostAddViewModel(addPost: addPostStub)
        stateReader = StateReader(sut)
    }
    
    func testLoadingState() {
        sut.addPostWith(title: "", content: "")
        
        XCTAssertEqual(stateReader.states, [.loading])
    }
    
    func testUpdateSuccess() {
        let randomPost = generator.post()
        addPostStub.returnResult = true
        addPostStub.mockedPost = randomPost
        
        sut.addPostWith(title: "", content: "")
        
        XCTAssertEqual(stateReader.states, [.loading, .success(randomPost)])
    }
    
    func testUpdateFail() {
        addPostStub.returnResult = true
        
        sut.addPostWith(title: "", content: "")
        
        XCTAssertEqual(stateReader.states, [.loading, .error])
    }
}
