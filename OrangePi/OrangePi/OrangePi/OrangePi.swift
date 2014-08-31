//
//  OrangePi.swift
//  OrangePi
//
//  Created by edward on 8/29/14.
//  Copyright (c) 2014 edwardsharp. All rights reserved.
//

import Foundation
import CoreData

@objc(OrangePi)
class OrangePi: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var address: String
    @NSManaged var port: String
    @NSManaged var username: String
    @NSManaged var password: String
    @NSManaged var timeStampString: String
    

}
