//
//  KeyChainService.swift
//  InstaTok
//
//  Created by 江一帆 on 11/17/22.
//

import Foundation
import KeychainSwift

class KeyChainService{
    var _keyChain = KeychainSwift()
    
    var keyChain: KeychainSwift {
        get {
            return _keyChain
        }
        set {
            _keyChain = newValue
        }
    }
    
}
