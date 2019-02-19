//
//  MyGroupController.swift
//  AppForVK
//
//  Created by Семериков Михаил on 26.12.2018.
//  Copyright © 2018 Семериков Михаил. All rights reserved.
//

import UIKit
import RealmSwift

class MyGroupController: UITableViewController {
    
    let vkService = VKService()
    var groups = [Group]()
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            let allGroupController = segue.source as! AllGroupController
            if let indexPath = allGroupController.tableView.indexPathForSelectedRow {
                let group = allGroupController.filteredGroup[indexPath.row]
                if !groups.contains(group) {
                    groups.append(group)
                    tableView.reloadData()
                    vkService.joinGroup(for: group.id)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 44
        
        vkService.loadVKGroups(for: Session.shared.userId) { [weak self] groups, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let groups = groups, let self = self {
                self.groups = groups
                self.saveGroups(groups)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myGroupCell", for: indexPath) as? MyGroupCell else { return UITableViewCell() }
        cell.configure(with: groups[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            vkService.leaveGroup(for: groups[indexPath.row].id)
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Realm
    
    func saveGroups(_ groups: [Group]) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            //let realm = try Realm()
            realm.beginWrite()
            realm.add(groups, update: true)
            try realm.commitWrite()
            print(realm.configuration.fileURL!)
        } catch {
            print(error)
        }
    }
}
