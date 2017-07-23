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
import GooglePlaces
import GooglePlacePicker

class AddReminderViewController: UITableViewController, GMSPlacePickerViewControllerDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
  
    @IBOutlet weak var startDateBtn: UIButton!
    @IBOutlet weak var endDateBtn: UIButton!

    @IBOutlet weak var locationSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func editStartDate(_ sender: Any) {
        datePickerSettings()
    }
    
    @IBAction func editEndDate(_ sender: Any) {
        datePickerSettings()
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
    
    func datePickerSettings() {
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
    
    // MARK: - Places Picker code
    
    @IBAction func pickPlace(_ sender: UIButton) {
        //let config = GMSPlacePickerConfig(viewport: nil)
        
        let center = CLLocationCoordinate2D(latitude: -33.865143, longitude: 151.2099)
        let northEast = CLLocationCoordinate2D(latitude: center.latitude + 0.001,
                                               longitude: center.longitude + 0.001)
        let southWest = CLLocationCoordinate2D(latitude: center.latitude - 0.001,
                                               longitude: center.longitude - 0.001)
        let viewport = GMSCoordinateBounds(coordinate: northEast, coordinate: southWest)
        
        let config = GMSPlacePickerConfig(viewport: viewport)
        let placePicker = GMSPlacePickerViewController(config: config)

        present(placePicker, animated: true, completion: nil)
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        print("Place name \(place.name)")
        print("Place address \(String(describing: place.formattedAddress))")
        print("Place attributions \(String(describing: place.attributions))")
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        print("No place selected")
    }
    
    
}


