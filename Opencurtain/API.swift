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
    static let shared: NetworkRequest = NetworkRequest()
    private init() { }
    
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
    
    func request<T: Results>(api: API, method: Alamofire.HTTPMethod, type: T.Type, completion handler: @escaping ([T.M]) -> Void) {
        Alamofire.request(baseURL+api.rawValue, method: method).responseObject { (response: DataResponse<T>) in
            let data = response.result.value
            if let result = data?.results {
                handler(result)
            }
        }
    }
    
//    func request(api: API, method: Alamofire.HTTPMethod, completion handler: @escaping (DefaultDataResponse) -> Void) {
//        (Alamofire.request(baseURL+api.rawValue, method: method) as AnyObject).response { response in
//            response.result.value
//        }
//    }
    
    
}

protocol Results: Mappable {
    associatedtype M: Mappable
    
    var count: Int { get set }
    var next: String { get set }
    var previous: String { get set }
    var results: [M] { get set }
}

class Users: Results {
    var count: Int = 0
    var next: String = ""
    var previous: String = ""
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

class Subcribes: Results {
    var count: Int = 0
    var next: String = ""
    var previous: String = ""
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

class Boards: Results {
    var count: Int = 0
    var next: String = ""
    var previous: String = ""
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

class Universitys: Results {
    var count: Int = 0
    var next: String = ""
    var previous: String = ""
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

class Facultys: Results {
    var count: Int = 0
    var next: String = ""
    var previous: String = ""
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

class Departments: Results {
    var count: Int = 0
    var next: String = ""
    var previous: String = ""
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

class Posts: Results {
    var count: Int = 0
    var next: String = ""
    var previous: String = ""
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
        timestamp <- map["timestemp"]
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

