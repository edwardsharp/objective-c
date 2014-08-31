//
//  UserPi.swift
//  OrangePi
//
//  Created by edward on 8/31/14.
//  Copyright (c) 2014 edwardsharp. All rights reserved.
//

import Foundation
import CoreData

@objc(UserPi)
class UserPi: NSManagedObject {

    @NSManaged var address: String
    @NSManaged var lastSeen: NSDate
    @NSManaged var name: String
    @NSManaged var order: NSNumber
    @NSManaged var password: String
    @NSManaged var port: NSNumber
    @NSManaged var sshKey: String
    @NSManaged var timeStamp: NSDate
    @NSManaged var timeStampString: String
    @NSManaged var username: String

}
