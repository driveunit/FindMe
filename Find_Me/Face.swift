//
//  Face.swift
//  Find_Me
//
//  Created by ramyahar on 3/22/18.
//  Copyright © 2018 ramyahar. All rights reserved.
//

import Foundation
import ARKit

class Face {
    let name: String
    let node: SCNNode
    var hidden: Bool {
        get{
            return node.opacity != 1
        }
    }
    var timestamp: TimeInterval {
        didSet {
            updated = Date()
        }
    }
    private(set) var updated = Date()
    
    init(name: String, node: SCNNode, timestamp: TimeInterval) {
        self.name = name
        self.node = node
        self.timestamp = timestamp
    }
}

extension Date {
    func isAfter(seconds: Double) -> Bool {
        let elapsed = Date.init().timeIntervalSince(self)
        
        if elapsed > seconds {
            return true
        }
        return false
    }
}
