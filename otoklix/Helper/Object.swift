//
//  Object.swift
//  otoklix
//
//  Created by harrie yusuf on 22/01/22.
//

import Foundation

class Object<T> {
    var event: ((T) -> ())?
    func listen(_ event: ((T) -> ())?) {
        self.event = event
    }
    
    func change(_ object: T) {
        event?(object)
    }
}
