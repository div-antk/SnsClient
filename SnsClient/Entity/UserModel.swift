//
//  UserModel.swift
//  SnsClient
//
//  Created by Takuya Ando on 2021/09/09.
//

import Foundation

public struct UserModel: Codable {
    let text: String
    let _created_at: String
    let _user_id: String
    let User: User
    
    public struct User: Codable {
        let id: String
        let description: String
        let name: String
    }
}


