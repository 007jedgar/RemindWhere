//
//  AddReminderViewController.swift
//  RemindWhere
//
//  Created by Jonathan Edgar on 7/19/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import Foundation
import UIKit
import DateTimePicker
import RealmSwift

class AddReminderViewController: UITableViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    //@IBOutlet weak var locationTextField: UITextField!
  
    @IBOutlet weak var startDateBtn: UIButton!
    @IBOutlet weak var endDateBtn: UIButton!

    @IBOutlet weak var locationSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func editStartDate(_ sender: Any) {
        let min = Date()
        let max = Date().addingTimeInterval(60 * 60 * 24 * 14)
        let picker = DateTimePicker.show(minimumDate: min, maximumDate: max)
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.darkColor = UIColor.darkGray
        picker.doneButtonTitle = "DONE!"
        picker.todayButtonTitle = "Today"
        picker.is12HourFormat = true
        picker.dateFormat = "hh:mm aa dd/MM/YYYY"
        picker.completionHandler = { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm aa dd/MM/YYYY"
            self.startDateBtn.titleLabel?.text = formatter.string(from: date)
        }
    }
    
    @IBAction func editEndDate(_ sender: Any) {
        let min = Date()
        let max = Date().addingTimeInterval(60 * 60 * 24 * 14)
        let picker = DateTimePicker.show(minimumDate: min, maximumDate: max)
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.darkColor = UIColor.darkGray
        picker.doneButtonTitle = "DONE!"
        picker.todayButtonTitle = "Today"
        picker.is12HourFormat = true
        picker.dateFormat = "hh:mm aa dd/MM/YYYY"
        picker.completionHandler = { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm aa dd/MM/YYYY"
            self.endDateBtn.titleLabel?.text = formatter.string(from: date)
        }
    }
    
    
    
    
    
    // MARK: - Creating/Saving new realm objects
    
    func makeReminder() {
        let title = self.titleTextField.text
        let description = self.descriptionTextField.text
        let location = self.locationSearchBar.text
        
        let newReminder = Reminder(value: ["title": title, "detail": description, "location": location ])
        addReminder(newReminder: newReminder)
    }
    
    func addReminder(newReminder: Reminder) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(newReminder)
        }
    }
    
    // MARK: - Delegates and stuff
    
    
}


