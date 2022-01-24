//
//  Adapter.swift
//  otoklix
//
//  Created by harrie yusuf on 23/01/22.
//

import Foundation

protocol WithState {
    associatedtype GenericState
    
    var state: Object<GenericState> { get set }
}
