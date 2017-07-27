//
//  Reminder.swift
//  RemindWhere
//
//  Created by Jonathan Edgar on 7/19/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import Foundation
import MapKit
import RealmSwift

class Reminder: Object {
    
    dynamic var title: String = ""
    dynamic var detail: String = ""
    dynamic var startDate: Data? = nil
    dynamic var endDate: Data? = nil
    dynamic var location: String = ""
    
}

class Place: Object {
    
    dynamic var name: String = ""
    dynamic var address: String = ""
    
}
