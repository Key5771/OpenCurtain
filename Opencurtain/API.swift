//
//  File.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/24.
//  Copyright © 2019 김기현. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper
import Alamofire

class NetworkRequest {
    let baseURL = "http://opencurtain.run.goorm.io"
    
    
    enum API: String {
        case users = "/users"
        case subscribes = "/subscribes"
        case boards = "/boards"
        case universitys = "/universitys"
        case facultys = "/facultys"
        case departments = "/departments"
        case posts = "/posts"
        case comments = "/comments"
    }

    
    
    
//    func request(api: API, method: Alamofire.HTTPMethod, completion handler: @escaping (DefaultDataResponse) -> Void) {
//        (Alamofire.request(baseURL+api.rawValue, method: method) as AnyObject).response { response in
//            response.result.value
//        }
//    }
    
    
}

class Users: Mappable {
    var count: Int = 0
    var next: Int = 0
    var previous: Int = 0
    var results: [User] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        next <- map["next"]
        previous <- map["previous"]
    }
}

class User {
    var id: Int = 0
    var username: String = ""
    var email: String = ""
    var university: Int = 0
    var faculty: Int = 0
    var department: Int = 0
}

class Subcribes: Mappable {
    var count: Int = 0
    var next: Int = 0
    var previous: Int = 0
    var results: [Subcribe] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        next <- map["next"]
        previous <- map["previous"]
        results <- map["results"]
    }
}

class Subcribe {
    var id: Int = 0
    var user: Int = 0
    var board: Int = 0
}

class Boards: Mappable {
    var count: Int = 0
    var next: Int = 0
    var previous: Int = 0
    var results: [Board] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        next <- map["next"]
        previous <- map["previous"]
        results <- map["results"]
    }
}

class Board {
    var url: String = ""
    var id: Int = 0
    var boardname: String = ""
}

class Universitys: Mappable {
    var count: Int = 0
    var next: Int = 0
    var previous: Int = 0
    var results: [University] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        next <- map["next"]
        previous <- map["previous"]
        results <- map["results"]
    }
}

class University {
    var id: Int = 0
    var universityName: String = ""
    var board: Int = 0
}

class Facultys: Mappable {
    var count: Int = 0
    var next: Int = 0
    var previous: Int = 0
    var results: [Faculty] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        next <- map["next"]
        previous <- map["previous"]
        results <- map["results"]
    }
}

class Faculty {
    var id: Int = 0
    var facultyName: String = ""
    var university: Int = 0
    var board: Int = 0
}

class Departments: Mappable {
    var count: Int = 0
    var next: Int = 0
    var previous: Int = 0
    var results: [Department] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        next <- map["next"]
        previous <- map["previous"]
        results <- map["results"]
    }
}

class Department {
    var id: Int = 0
    var departmentName: String = ""
    var faculty: Int = 0
    var university: Int = 0
    var board: Int = 0
}

class Posts: Mappable {
    var count: Int = 0
    var next: Int = 0
    var previous: Int = 0
    var results: [Post] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        next <- map["next"]
        previous <- map["previous"]
        results <- map["results"]
    }
}

class Post {
    var id: Int = 0
    var user: String = ""
    var board: String = ""
    var timestamp: String = ""
    var title: String = ""
    var content: String = ""
}

class Comments: Mappable {
    var count: Int = 0
    var next: Int = 0
    var previous: Int = 0
//    var results = [String] = [""]
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        next <- map["next"]
        previous <- map["previous"]
//        results <- map["results"]
    }
}

