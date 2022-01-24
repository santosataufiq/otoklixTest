//
//  StateReader.swift
//  otoklixTests
//
//  Created by harrie yusuf on 23/01/22.
//

import Foundation
@testable import otoklix

final class StateReader<T: WithState> {
    var states: [T.GenericState] = []
    private let vm: T

    init(_ vm: T) {
        self.vm = vm
        listen()
    }
    
    private func listen() {
        vm.state.listen { [unowned self] state in
            self.states.append(state)
        }
    }
}
