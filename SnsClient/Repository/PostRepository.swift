//
//  PostRepository.swift
//  SnsClient
//
//  Created by Takuya Ando on 2021/07/20.
//

import Foundation
import Moya
import RxSwift

final class PostRepository {
    private static let apiProvider = MoyaProvider<SnsAPI>()
    private static let disposeBag = DisposeBag()
}

extension PostRepository {
    
    static func getAllPosts() -> Observable<[Post]> {
        return apiProvider.rx.request(.posts)
            .map { response in
                print("(´・ω・｀)", response.response)
                let decoder = JSONDecoder()
                return try decoder.decode([Post].self, from: response.data)
            }.asObservable()
    }
}
