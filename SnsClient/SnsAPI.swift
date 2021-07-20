//
//  SnsAPI.swift
//  SnsClient
//
//  Created by Takuya Ando on 2021/07/20.
//

import Foundation
import Moya

enum SnsAPI {
    case posts
}

extension SnsAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://versatileapi.herokuapp.com/api/")!
    }
    
    var path: String {
        switch self {
        case .posts:
            return "/text/all"
        }
    }
    
    var method: Moya.Method {
        return Moya.Method.get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .posts:
            return .requestPlain
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
