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
        describe("initialization") {
            it("converts from plist/dictionary") {
                let filePath = "/dev/null"
                let name = "profile-1"
                let creationDate = NSDate()
                let expirationDate = NSDate()

                let data = ["Name": name, "CreationDate": creationDate, "ExpirationDate": expirationDate]
                let profile = Profile(filePath: filePath, data: data)
                expect(profile).toNot(beNil())
                expect(profile?.filePath).to(equal(filePath))
                expect(profile?.name).to(equal(name))
                expect(profile?.creationDate).to(equal(creationDate))
                expect(profile?.expirationDate).to(equal(expirationDate))
            }

            it("does not convert from invalid plist/dictionary") {
                let filePath = "/dev/null"
                let name = "profile-1"

                let data = ["Name": name]
                let profile = Profile(filePath: filePath, data: data)
                expect(profile).to(beNil())
            }
        }

        describe("status") {
            it("is expired when current date is later than expirationDate") {
                let filePath = "/dev/null"
                let name = "profile-1"
                let creationDate = NSDate()
                let expirationDate = NSDate(timeIntervalSinceNow: -1)

                let data = ["Name": name, "CreationDate": creationDate, "ExpirationDate": expirationDate]
                let profile = Profile(filePath: filePath, data: data)

                expect(profile?.status).to(equal(ProfileStatus.Expired))
            }

            it("is expired when current date is equal to expirationDate") {
                let filePath = "/dev/null"
                let name = "profile-1"
                let creationDate = NSDate()
                let expirationDate = NSDate()

                let data = ["Name": name, "CreationDate": creationDate, "ExpirationDate": expirationDate]
                let profile = Profile(filePath: filePath, data: data)

                expect(profile?.status).to(equal(ProfileStatus.Expired))
            }

            it("is ok when current date is prior than expirationDate") {
                let filePath = "/dev/null"
                let name = "profile-1"
                let creationDate = NSDate()
                let expirationDate = NSDate(timeIntervalSinceNow: 1)

                let data = ["Name": name, "CreationDate": creationDate, "ExpirationDate": expirationDate]
                let profile = Profile(filePath: filePath, data: data)

                expect(profile?.status).to(equal(ProfileStatus.OK))
            }
        }

        describe("team") {
            var data: [String: AnyObject]!
            let filePath = "/dev/null"
            beforeEach {
                let name = "profile-1"
                let creationDate = NSDate()
                let expirationDate = NSDate()

                data = ["Name": name, "CreationDate": creationDate, "ExpirationDate": expirationDate]
            }

            it("has team id if present in plist") {
                let teamID = "01234X"
                data["TeamIdentifier"] = [teamID]
                let profile = Profile(filePath: filePath, data: data)

                expect(profile?.teamID).to(equal(teamID))
            }

            it("has team name if present in plist") {
                let teamName = "Team A"
                data["TeamName"] = teamName
                let profile = Profile(filePath: filePath, data: data)

                expect(profile?.teamName).to(equal(teamName))
            }

            it("has neither if missing") {
                let profile = Profile(filePath: filePath, data: data)
                expect(profile?.teamID).to(beNil())
                expect(profile?.teamName).to(beNil())
            }
        }
    }
}
