//
//  Storage.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/30.
//  Copyright © 2019 김기현. All rights reserved.
//

import Foundation

class Storage {
    static let shared = Storage()
    private init() {
        getSubscribe { }
    }
    
    var subscribes: [Subscribe] = []
    var user = User()
    
    func getSubscribe(handler: @escaping () -> Void) {
        NetworkRequest.shared.requestArray(api: .subscribes, method: .get, type: Subscribe.self) { (subscribes) in
            Storage.shared.subscribes = subscribes
            handler()
        }
    }
    
    func deleteSubscribe(subscribeId: Int, handler: @escaping (Error?) -> Void) {
        NetworkRequest.shared.request(url: "/subscribes/\(subscribeId)", method: .delete) { (error) in
            if error == nil {
                self.subscribes.removeAll { (subscribe) -> Bool in
                    return subscribe.id == subscribeId
                }
            }
            handler(error)
        }
    }
    
    func checkUser(handler: @escaping (Error?) -> Void) {
        NetworkRequest.shared.request(api: .users, method: .get, type: User.self) { (response) in
            if response != nil {
                self.user = response!
                handler(nil)
            } else {
                handler(NetworkRequest.NetworkError.http404)
            }
        }
    }
}
