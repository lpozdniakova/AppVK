//
//  AllGroupController.swift
//  AppForVK
//
//  Created by Семериков Михаил on 26.12.2018.
//  Copyright © 2018 Семериков Михаил. All rights reserved.
//

import UIKit

class AllGroupController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar! //searchGroups

    let searchController = UISearchController(searchResultsController: nil)
    let arrayGroup = ["AI", "WEB", "Python", "Java", "Game Dev", "iOS", "Android", "InfoSec"]
    var arrayGroupsImage = ["AI": "iconAI.png", "WEB": "iconWEB.png", "Python": "iconPython", "Java": "iconJava.png", "Game Dev": "iconGameDev.png", "iOS": "iconIOS.png", "Android": "iconAndroid.png", "InfoSec": "iconInfoSec.png"]
    var filteredGroup: [String] = []
    var searchActive : Bool = false
    
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0
    var textFieldInsideSearchBar: UITextField?
    var iconView: UIImageView?
    
    let vkService = VKService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        offsetX = searchBar.frame.width / 2 - 14
        offsetY = searchBar.searchFieldBackgroundPositionAdjustment.vertical
        searchBar.setPositionAdjustment(UIOffset(horizontal: offsetX, vertical: offsetY), for: .search)
        textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        iconView = textFieldInsideSearchBar?.leftView as? UIImageView
    }

    // MARK: - Search Bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchActive = false
        } else {
            filteredGroup = arrayGroup.filter({(text) -> Bool in
                let tmp: NSString = text as NSString
                let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
            vkService.searchVKGroups(q: searchText)
            searchActive = true}
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIView.transition(with: searchBar, duration: 0.5, options: .transitionCrossDissolve, animations: {self.searchBar.setShowsCancelButton(true, animated: true)})
        self.searchBar.setPositionAdjustment(UIOffset(horizontal: 0, vertical: 0), for: .search)
        UIView.animate(withDuration: 1, delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {self.iconView?.transform = CGAffineTransform(translationX: -20, y: 0)}) { (true) in self.iconView?.transform = .identity}
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.transition(with: searchBar, duration: 0.5, options: .transitionCrossDissolve, animations: {self.searchBar.setShowsCancelButton(false, animated: true)})
        searchBar.setPositionAdjustment(UIOffset(horizontal: offsetX, vertical: offsetY), for: .search)
        searchBar.resignFirstResponder()
        searchBar.text = nil
        searchBar.endEditing(true)
        searchActive = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Table view data source
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayGroup.count;
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filteredGroup.count
        } else {
            return arrayGroup.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupCell", for: indexPath) as! AllGroupCell
        
        if searchActive {
            cell.allGroupName.text = filteredGroup[indexPath.row]
            if let nameAvatar = arrayGroupsImage[filteredGroup[indexPath.row]] {
                cell.allGroupImage.image = UIImage(named: nameAvatar)
            }
        } else { cell.allGroupName.text = arrayGroup[indexPath.row]
            //cell.allGroupName.text = group
            if let nameAvatar = arrayGroupsImage[arrayGroup[indexPath.row]] {
                cell.allGroupImage.image = UIImage(named: nameAvatar)
            }
        }
        return cell
    }
}

