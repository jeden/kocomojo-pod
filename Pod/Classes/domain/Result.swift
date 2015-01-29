//
//  Result.swift
//  KocomojoKit
//
//  Created by Antonio Bello on 1/27/15.
//  Copyright (c) 2015 Elapsus. All rights reserved.
//

class Box<T> {
    let unbox: T
    
    init(_ value: T) {
        self.unbox = value
    }
}

public enum Result<T> {
    case Value(@autoclosure () -> T)
    case Error(NSError)
}