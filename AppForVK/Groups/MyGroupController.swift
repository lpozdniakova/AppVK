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
    
    private let vkService = VKService()
    private let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    private var groups: Results<Group>?
    private var notificationToken: NotificationToken?
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroup" {
            let allGroupController = segue.source as! AllGroupController
            if let indexPath = allGroupController.tableView.indexPathForSelectedRow {
                let group = allGroupController.filteredGroup[indexPath.row]
                
                do {
                    guard let realm = try? Realm(configuration: self.config) else { return }
                    realm.beginWrite()
                    vkService.joinGroup(for: group.id)
                    realm.add(group, update: true)
                    try realm.commitWrite()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 44
        pairTableAndRealm()
        
        vkService.loadVKGroups(for: Session.shared.userId) { groups, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else if let groups = groups {
                RealmProvider.save(items: groups)
            }
        }
    }
    
    /*override func viewWillDisappear(_ animated: Bool) {
        notificationToken?.invalidate()
    }*/
    
    func pairTableAndRealm() {
        //let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        guard let realm = try? Realm() else { return }
        groups = realm.objects(Group.self)
        
        notificationToken = groups?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .none)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .none)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .none)
                tableView.endUpdates()
                break
            case .error(let error):
                fatalError("\(error)")
                break
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myGroupCell", for: indexPath) as? MyGroupCell else { return UITableViewCell() }
        cell.configure(with: groups![indexPath.row]) //TODO: - Убрать force-unwrap
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let group = groups?[indexPath.row] else { return }
            do {
                guard let realm = try? Realm(configuration: self.config) else { return }
                realm.beginWrite()
                vkService.leaveGroup(for: group.id)
                realm.delete(group)
                try realm.commitWrite()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
