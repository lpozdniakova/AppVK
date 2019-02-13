//
//  MyGroupController.swift
//  AppForVK
//
//  Created by Семериков Михаил on 26.12.2018.
//  Copyright © 2018 Семериков Михаил. All rights reserved.
//

import UIKit

class MyGroupController: UITableViewController {
    
    var myGroup = ["iOS"]
    var myGroupImage = ["iOS": "iconIOS"]
    
    let vkService = VKService()
    var groups = [Group]()
    //TODO: - Реализовать функционал добавления группы
    /*@IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            let allGroupController = segue.source as! AllGroupController
            if allGroupController.searchActive == false {
                if let indexPath = allGroupController.tableView.indexPathForSelectedRow {
                    let group = allGroupController.arrayGroup[indexPath.row]
                    let groupImage = allGroupController.arrayGroupsImage[group]
                    if !myGroup.contains(group) {
                        myGroup.append(group)
                        myGroupImage[group] = groupImage
                        tableView.reloadData()
                    }
                }
            } else {
                if let indexPath = allGroupController.tableView.indexPathForSelectedRow {
                    let group = allGroupController.filteredGroup[indexPath.row]
                    let groupImage = allGroupController.arrayGroupsImage[group]
                    if !myGroup.contains(group) {
                        myGroup.append(group)
                        myGroupImage[group] = groupImage
                        tableView.reloadData()
                    }
                }
            }
        }
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 44
        
        vkService.loadVKGroups(for: Session.shared.userId) { [weak self] groups, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let groups = groups, let self = self {
                self.groups = groups
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
 
    // Override to support editing the table view.
    //TODO: - Сделать чтобы при свайпе исключался из группы
    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //myGroup.remove(at: indexPath.row)
            
            let keyGroup = myGroup[indexPath.row]
            myGroup.remove(at: indexPath.row)
            myGroupImage.removeValue(forKey: keyGroup)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }*/
}
