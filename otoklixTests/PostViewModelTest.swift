//
//  PostViewModelTest.swift
//  otoklixTests
//
//  Created by harrie yusuf on 22/01/22.
//

import XCTest
@testable import otoklix

final class PostListViewModelTest: XCTestCase {
    let generator = Generator()
    var sut: PostListViewModel!
    var loadPostStub: LoadPostStub!
    var stateReader: StateReader<PostListViewModel>!
    
    override func setUp() {
        loadPostStub = LoadPostStub()
        sut = PostListViewModel(loadPost: loadPostStub)
        stateReader = StateReader(sut)
    }
    
    func testLoadingState() {
        sut.load()
        
        XCTAssertEqual(stateReader.states, [.loading])
    }
    
    func testLoadDataSuccess() {
        let posts = generator.posts(count: 3)
        loadPostStub.returnResult = true
        loadPostStub.posts = posts
        
        sut.load()
        
        XCTAssertEqual(stateReader.states, [.loading, .show(posts)])
    }
    
    func testLoadDataFail() {
        loadPostStub.returnResult = true
        
        sut.load()
        
        XCTAssertEqual(stateReader.states, [.loading, .error])
    }
}
