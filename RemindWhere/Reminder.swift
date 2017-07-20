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
    
//    init(title: String, detail: String, startDate: Data, endDate: Data, location: String) {
//        self.title = title
//        self.detail = detail
//        self.startDate = startDate
//        self.endDate = endDate
//        self.location = location
//    }
}
