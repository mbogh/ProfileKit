//
//  ProfileTests.swift
//  ProfileKit
//
//  Created by Morten Bøgh on 24/01/15.
//  Copyright (c) 2015 Morten Bøgh. All rights reserved.
//

import Quick
import Nimble
import ProfileKit

class ProfileTests: QuickSpec {
    override func spec() {
        it("converts from plist/dictionary") {
            let filePath = "/dev/null"
            let name = "profile-1"
            let creationDate = NSDate()
            let expirationDate = NSDate()

            let data = ["Name": name, "CreationDate": creationDate, "ExpirationDate": expirationDate]
            let profile = Profile(filePath: filePath, data: data)
            expect(profile).toNot(beNil())
            expect(profile?.name).to(equal(name))
            expect(profile?.creationDate).to(equal(creationDate))
            expect(profile?.expirationDate).to(equal(expirationDate))
        }
    }
}
