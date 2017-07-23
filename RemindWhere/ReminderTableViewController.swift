//
//  ReminderTableViewController.swift
//  RemindWhere
//
//  Created by Jonathan Edgar on 7/19/17.
//  Copyright © 2017 Jonathan Edgar. All rights reserved.
//

import UIKit
import RealmSwift

class ReminderTableViewController: UITableViewController {

    var reminders = [Reminder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(adddRemider))
        queryRealm()
        //addRemidnerButton()
        testReminders()
        self.tableView.reloadData()
    }
    
    // MARK: - Realm test reminders
    
    func testReminders() {

        let testRem = Reminder(value: [
            "title": "test1",
            "detail": "test detail1"
            ])
        
        let testRem1 = Reminder(value: [
            "title": "test2",
            "detail": "test detail2"
            ])
        
        let testRem2 = Reminder(value: [
            "title": "test3",
            "detail": "test detail3"
            ])
        
        let realm = try! Realm()

        try! realm.write {
            realm.add(testRem)
            realm.add(testRem1)
            realm.add(testRem2)
        }
    }
    
    // MARK: - Add Reminder Button (back burner for now)
    
//    func addRemidnerButton() {
//        let button = UIButton(type: .custom)
//        button.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
//        button.layer.cornerRadius = button.frame.size.width / 5
//        button.clipsToBounds = true
//        button.titleLabel?.text = "+"
//        button.backgroundColor = UIColor(red: 132/255.0, green: 123/255.0, blue: 123/255.0, alpha: 1)
//        button.titleLabel?.textColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
//        button.addTarget(self, action: #selector(adddRemider), for: .touchUpInside)
//        self.view.addSubview(button)
//    }
    
    // MARK: - Segues and stuff
    
    func adddRemider() {
        let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "AddReminderViewController") as! AddReminderViewController
        let topVC: UINavigationController = UINavigationController(rootViewController: vc1)
        self.present(topVC, animated: true, completion: nil)
    }
    
    // MARK: - Realm data query
    
    func queryRealm() {
        self.reminders.removeAll()
        let realm = try! Realm()
        let resultsByStartDate = realm.objects(Reminder.self)
        for result in resultsByStartDate {
        self.reminders.append(result)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reminder Cell", for: indexPath)
        let reminder = reminders[indexPath.row]
        cell.textLabel?.text = reminder.title
        cell.detailTextLabel?.text = reminder.detail
        return cell
    }
}





