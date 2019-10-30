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
    
    enum API: String{
        
        case users = "/user/"
        case subscribes = "/subscribes/"
        case boards = "/boards/"
        case universitys = "/universitys/"
        case facultys = "/facultys/"
        case departments = "/departments/"
        case posts = "/posts/"
        case comments = "/comments/"
        case authcode = "/authcode/"
        case authcheck = "/authcheck/"
        case login = "/user/login/"
        case logout = "/user/logout"
    }

    // api 정해져 있는 경우
    func requestArray<T: Mappable>(api: API, method: Alamofire.HTTPMethod, type: T.Type, parameters: Parameters? = nil, completion handler: @escaping ([T]) -> Void) {
        Alamofire.request(baseURL+api.rawValue, method: method, parameters: parameters).responseArray { (response: DataResponse<[T]>) in
            let data = response.result.value
            if let result = data {
                handler(result)
            }
        }
    }
    
    // api 동적으로 변하는 경우
    func requestArray<T: Mappable>(url: String, method: Alamofire.HTTPMethod, type: T.Type, parameters: Parameters? = nil, completion handler: @escaping ([T]) -> Void) {
        Alamofire.request(baseURL+url, method: method, parameters: parameters).responseArray { (response: DataResponse<[T]>) in
            let data = response.result.value
            if let result = data {
                handler(result)
            }
        }
    }
    
    
    func request(api: API, method: Alamofire.HTTPMethod, parameters: Parameters? = nil, completion handler: @escaping (Error?) -> Void) {
        Alamofire.request(baseURL+api.rawValue, method: method, parameters: parameters).response { (response) in
            if response.response?.statusCode == 200 {
                handler(nil)
            } else {
                handler(NetworkError.http404)
                print("StatusCode:\(response.response?.statusCode), RequestURL:\(response.request?.url), Headerr:\(response.request?.httpBody)")
            }
        }
    }
    
    func request<T: Mappable>(api: API, method: Alamofire.HTTPMethod, type: T.Type, parameters: Parameters? = nil, completion handler: @escaping (T?) -> Void) {
        Alamofire.request(baseURL+api.rawValue, method: method, parameters: parameters).responseObject { (response: DataResponse<T>) in
            let data = response.result.value
                handler(data)
        }
    }
    
    func request(url: String, method: Alamofire.HTTPMethod, parameters: Parameters? = nil, completion handler: @escaping (Error?) -> Void) {
        Alamofire.request(baseURL+url, method: method, parameters: parameters).response { (response) in
            if response.response?.statusCode == 200 {
                handler(nil)
            } else {
                handler(NetworkError.http404)
                print("StatusCode:\(response.response?.statusCode), RequestURL:\(response.request?.url), Headerr:\(response.request?.httpBody)")
            }
        }
    }
    
    enum NetworkError: Error {
        case http404
    }
    
//    func request(api: API, method: Alamofire.HTTPMethod, completion handler: @escaping (DefaultDataResponse) -> Void) {
//        (Alamofire.request(baseURL+api.rawValue, method: method) as AnyObject).response { response in
//            response.result.value
//        }
//    }
    
    
}



class User: Mappable {
    var id: Int = 0
    var username: String = ""
    var email: String = ""
    var password: String = ""
    var university: String = ""
    var faculty: String = ""
    var department: String = ""
    var authcode: Int = 0
    
    init() { }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        email <- map["email"]
        password <- map["password"]
        university <- map["university"]
        faculty <- map["faculty"]
        department <- map["department"]
        authcode <- map["authcode"]
    }
}


class Subscribe: Mappable, Equatable {
    var id: Int = 0
    var board: Int = 0
    var boardname: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        board <- map["board"]
        boardname <- map["boardname"]
    }
    
    static func == (lhs: Subscribe, rhs: Subscribe) -> Bool {
        return lhs.board == rhs.board
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


class University: Mappable {
    var id: Int = 0
    var universityName: String = ""
    var board: Int = 0
    
    init() { }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        universityName <- map["universityname"]
        board <- map["board"]
    }
}


class Faculty: Mappable {
    var id: Int = 0
    var facultyName: String = ""
    var university: Int = 0
    var board: Int = 0
    
    init() { }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        facultyName <- map["facultyname"]
        university <- map["university"]
        board <- map["board"]
    }
}


class Department: Mappable {
    var id: Int = 0
    var departmentName: String = ""
    var faculty: Int = 0
    var university: Int = 0
    var board: Int = 0
    
    init() { }
    
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


class Post: Mappable {
    var id: Int = 0
    var user: Int = 0
    var username: String = ""
    var board: Int = 0
    var timestamp: String = ""
    var title: String = ""
    var content: String = ""
    var universityname: String = ""
    
    init() { }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        user <- map["user"]
        username <- map["username"]
        board <- map["board"]
        timestamp <- map["timestamp"]
        title <- map["title"]
        content <- map["content"]
        universityname <- map["universityname"]
    }
}


class Comment: Mappable {
    var id: Int = 0
    var user: Int = 0
    var username: String = ""
    var timestamp: String = ""
    var posts: Int = 0
    var comment: String = ""
    
    init() { }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        user <- map["user"]
        username <- map["username"]
        timestamp <- map["timestamp"]
        posts <- map["posts"]
        comment <- map["comment"]
    }
}

