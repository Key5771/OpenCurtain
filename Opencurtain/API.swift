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

class User: Mappable {
    var id: Int = 0
    var username: String = ""
    var email: String = ""
    var university: Int = 0
    var faculty: Int = 0
    var department: Int = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        email <- map["email"]
        university <- map["university"]
        faculty <- map["faculty"]
        department <- map["department"]
    }
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

class Subcribe: Mappable {
    var id: Int = 0
    var user: Int = 0
    var board: Int = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        user <- map["user"]
        board <- map["board"]
    }
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

class Board: Mappable {
    var url: String = ""
    var id: Int = 0
    var boardname: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        url <- map["url"]
        id <- map["id"]
        boardname <- map["boardname"]
    }
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

class University: Mappable {
    var id: Int = 0
    var universityName: String = ""
    var board: Int = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        universityName <- map["universityname"]
        board <- map["board"]
    }
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

class Faculty: Mappable {
    var id: Int = 0
    var facultyName: String = ""
    var university: Int = 0
    var board: Int = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        facultyName <- map["facultyname"]
        university <- map["university"]
        board <- map["board"]
    }
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

class Department: Mappable {
    var id: Int = 0
    var departmentName: String = ""
    var faculty: Int = 0
    var university: Int = 0
    var board: Int = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        departmentName <- map["departmentname"]
        faculty <- map["faculty"]
        university <- map["university"]
        board <- map["board"]
    }
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

class Post: Mappable {
    var id: Int = 0
    var user: String = ""
    var board: String = ""
    var timestamp: String = ""
    var title: String = ""
    var content: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        user <- map["user"]
        board <- map["board"]
        timestamp <- map["timestamp"]
        title <- map["title"]
        content <- map["content"]
    }
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

