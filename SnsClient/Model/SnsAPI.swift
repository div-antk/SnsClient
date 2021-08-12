//
//  SnsAPI.swift
//  SnsClient
//
//  Created by Takuya Ando on 2021/07/20.
//

import Foundation
import Moya

enum SnsAPI {
    case all
    case postText(text: String)
}

extension SnsAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://versatileapi.herokuapp.com/api")!
    }
    
    var path: String {
        switch self {
        case .all:
            return "/text/all"
        case .postText:
            return "/text"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .all:
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
        case .all:
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
