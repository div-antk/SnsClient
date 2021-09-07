//
//  UserRepository.swift
//  SnsClient
//
//  Created by Takuya Ando on 2021/09/03.
//

import Foundation
import Moya
import RxSwift

final class UserRepository {
    private static let apiProvider = MoyaProvider<SnsAPI>()
    private static let disposeBag = DisposeBag()
}

extension UserRepository {
    
    static func getUser(id: String) -> Observable<User> {
        return apiProvider.rx.request(.user(id: id))
            .map { response in
                print("(´・ω・｀)", response.response?.url)
                let decoder = JSONDecoder()
                return try decoder.decode(User.self, from: response.data)
            }.asObservable()
    }
}
