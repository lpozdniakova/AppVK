//
//  VKService.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 06/02/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation
import Alamofire

class VKService {
    let baseUrl = "https://api.vk.com"
    
    func loadVKFriends() {
        let path = "/method/friends.get"
        let parameters: Parameters = [
            "fields": "nickname, online",
            "count": "20",
            "access_token": Session.shared.token,
            "v": "5.92"
        ]
        let url = baseUrl + path
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in print(response.value as Any) }
    }
    
    func loadVKPhotos() {
        let path = "/method/photos.getAll"
        
        let parameters: Parameters = [
            "user_id": Session.shared.userId,
            "count": "20",
            "access_token": Session.shared.token,
            "v": "5.92",
            "no_service_albums": "0"
        ]
        let url = baseUrl + path
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in print(response.value as Any) }
    }
    
    func loadVKGroups() {
        let path = "/method/groups.get"
        let parameters: Parameters = [
            "user_id": Session.shared.userId,
            "extended": "1",
            "access_token": Session.shared.token,
            "v": "5.92"
        ]
        let url = baseUrl + path
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in print(response.value as Any) }
    }
    
    func searchVKGroups(q: String) {
        let path = "/method/groups.search"
        let parameters: Parameters = [
            "q": q,
            "count": 20,
            "access_token": Session.shared.token,
            "v": "5.92",
            "type": "group"
        ]
        let url = baseUrl + path
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in print(response.value as Any) }
    }
}
