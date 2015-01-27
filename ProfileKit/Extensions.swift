//
//  Extensions.swift
//  ProfileKit
//
//  Created by Morten Bøgh on 26/01/15.
//  Copyright (c) 2015 Morten Bøgh. All rights reserved.
//

import Foundation

/// Thanks to http://ulrikdamm.logdown.com/posts/247219
func bind<T, U>(optional : T?, f : T -> U?) -> U? {
    switch optional {
    case .Some(let v):
        return f(v)
    case .None:
        return nil
    }
}