//
//  Profile.swift
//  ProfileKit
//
//  Created by Morten Bøgh on 25/01/15.
//  Copyright (c) 2015 Morten Bøgh. All rights reserved.
//

import Foundation

public struct Profile {
    public let filePath: String

    public let name: String
    public let creationDate: NSDate
    public let expirationDate: NSDate

    /// Designated initializer
    public init?(filePath path: String, data: NSDictionary) {
        filePath = path

        if data["Name"] == nil { return nil }
        if data["CreationDate"] == nil { return nil }
        if data["ExpirationDate"] == nil { return nil }

        name = data["Name"] as String
        creationDate = data["CreationDate"] as NSDate
        expirationDate = data["ExpirationDate"] as NSDate
    }
}