//
//  ModelSource.swift
//  SimplestTTT
//
//  Created by verec on 05/12/2015.
//  Copyright © 2015 Cantabilabs Ltd. All rights reserved.
//

import Foundation

class ModelSource {

    var models:[Model] = []

    var count:Int {
        return models.count
    }

    subscript(index:Int) -> Model {
        return models[index]
    }

    init() {

        for rank in 0 ..< 50 {
            models.append(Model(rank: rank))
        }
    }
}