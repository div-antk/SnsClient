//
//  SnsAPI.swift
//  SnsClient
//
//  Created by Takuya Ando on 2021/07/20.
//

import Foundation
import Moya

enum SnsAPI {
    case allText
    case user(id: String)
    case postText(text: String)
    
}

extension SnsAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://versatileapi.herokuapp.com/api")!
    }
    
    var path: String {
        switch self {
        case .allText:
            return "/text/all"
        case .user(let id):
            return "/user/\(id)"
        case .postText:
            return "/text"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .allText, .user:
            return .get
        case .postText:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .allText, .user:
            return .requestPlain
        case .postText(let text):
            let jsonData = try! JSONSerialization.data(withJSONObject: [
                "text": text
            ], options: [])
            return .requestCompositeData(bodyData: jsonData, urlParameters: [:])
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [String : String]? {
        ["Authorization": "HelloWorld"]
    }
}
