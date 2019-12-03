//
//  VKServiceProxy.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 03.12.2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import Foundation

class VKServiceProxy: VKServiceInterface {
    let vkService: VKService
    init(vkService: VKService) {
        self.vkService = vkService
    }
    
    func loadVKGroups(for user: Int, completion: (([Group]?, Error?) -> Void)?) {
        self.vkService.loadVKGroups(for: user)
        print("called func loadVKGroups with user=\(user)")
    }
}
