//
//  MultiDispatch.swift
//  SlidingTableViewCellsOverlapBug
//
//  Created by verec on 05/12/2015.
//  Copyright © 2015 Cantabilabs Ltd. All rights reserved.
//

import Foundation

/// from answer to https://forums.developer.apple.com/thread/27546 
/// by OOPer

struct MultiDispatch<ArgType> {
    typealias GenericFuncSignature = ArgType -> ()
    let targets:[GenericFuncSignature]
    init(_ targets:GenericFuncSignature...) {
        self.targets = targets
    }
    func call(args:ArgType) {
        for f in targets {
            f(args)
        }
    }
}
