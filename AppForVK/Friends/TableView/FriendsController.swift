//
//  FriendsController.swift
//  AppForVK
//
//  Created by Семериков Михаил on 23.12.2018.
//  Copyright © 2018 Семериков Михаил. All rights reserved.
//

import UIKit

class FriendsController: UITableViewController, UISearchBarDelegate {
    
    //MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var friendTableView: UITableView!
    
    //MARK: - Variables and constants
    
    let transitionManager = TransitionManager()
    let searchController = UISearchController(searchResultsController: nil)
    var friendsArray: [Friends] = []
    var filteredFriend: [Friends] = []
    var letters: [Character] = []
    var lettersDictionary: [Character: [Friends]] = [:]
    var searchActive : Bool = false
    
    var offsetX: CGFloat = 0
    var offsetY: CGFloat = 0
    var textFieldInsideSearchBar: UITextField?
    var iconView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsArray = friendsDataBase
        filteredFriend = friendsArray
        updateFriendsIndex(friends: filteredFriend)
        updateFriendsNamesDictionary(friends: filteredFriend)
        self.tableView.rowHeight = 44
        
        offsetX = searchBar.frame.width / 2 - 14
        offsetY = searchBar.searchFieldBackgroundPositionAdjustment.vertical
        searchBar.setPositionAdjustment(UIOffset(horizontal: offsetX, vertical: offsetY), for: .search)
        textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        iconView = textFieldInsideSearchBar?.leftView as? UIImageView
        
        tableView.keyboardDismissMode = .onDrag
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return letters.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        guard !searchActive else { return nil }
        return letters.map { String($0) }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(letters[section])
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let char = letters[section]
        let rowsCount: Int = lettersDictionary[char]?.count ?? 0
        return rowsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let char = letters[indexPath.section]
        let friendName = lettersDictionary[char]?[indexPath.row].name ?? "Ошибка"
        let friendImage = UIImage(named: lettersDictionary[char]?[indexPath.row].avatarPath ?? "defaultImage.png")
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendsCell
        cell.friendImage.image = friendImage
        cell.friendName.text = friendName
        return cell
    }
    
    //MARK: - Setup searchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFriend = friendsArray.filter({ (friend) -> Bool in FirstLetterSearch.isMatched(searchBase: friend.name, searchString: searchText)})
        updateFriendsIndex(friends: filteredFriend)
        updateFriendsNamesDictionary(friends: filteredFriend)
        
        if (searchText.count == 0) {
            updateFriendsIndex(friends: friendsArray)
            updateFriendsNamesDictionary(friends: friendsArray)
            searchActive = false
            hideKeyboard()
        }
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
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
        updateFriendsIndex(friends: friendsArray)
        updateFriendsNamesDictionary(friends: friendsArray)
        searchActive = false
        hideKeyboard()
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        hideKeyboard()
    }
    
    @objc func hideKeyboard() {
        searchActive = false
        friendTableView?.endEditing(true)
    }
    
    //MARK: - Prepare data
    
    func updateFriendsNamesDictionary(friends: [Friends]) {
        lettersDictionary = SectionIndexManager.getFriendIndexDictionary(array: friends)
    }
    
    func updateFriendsIndex(friends: [Friends]) {
        letters = SectionIndexManager.getOrderedIndexArray(array: friends)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFriends" {
            let friendsCollectionController : FriendsCollectionController = segue.destination as! FriendsCollectionController
            if let selection = self.tableView.indexPathForSelectedRow {
                let char = letters[selection.section]
                if let selectedFriend = lettersDictionary[char]?[selection.row] {
                    friendsCollectionController.friendName = selectedFriend
                }
            }
        } 
    }
}
