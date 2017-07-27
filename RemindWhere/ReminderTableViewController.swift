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
        
        deleteReminders()
        addReminder()
        queryRealm()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let realm = try! Realm()
        if editingStyle == UITableViewCellEditingStyle.delete {
            let reminder = reminders[indexPath.row]
                try! realm.write {
                    realm.delete(reminder)
                }
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    // MARK: - Test reminders
    
    func deleteReminders() {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(reminders)
            realm.deleteAll()
        }
    }
    
    func addReminder() {
        let realm = try! Realm()
        
        let reminder = Reminder()
        reminder.detail = "testDetail1"
        reminder.title = "testTitle1"
        
        try! realm.write {
            realm.add(reminder)
        }
    }
    
    // MARK: - Add Reminder Button (back burner for now)
    
    func addRemidnerButton() { // Not implemented for testing
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        button.layer.cornerRadius = button.frame.size.width / 7
        button.clipsToBounds = true
        button.titleLabel?.text = "+"
        button.backgroundColor = UIColor(red: 232/255.0, green: 123/255.0, blue: 123/255.0, alpha: 1)
        button.titleLabel?.textColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
        button.addTarget(self, action: #selector(adddRemider), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
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





