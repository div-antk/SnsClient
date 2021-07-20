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
    private static let apiProvider = MoyaProvider<[SnsAPI]>()
    private static let disposeBag = DisposeBag()
}

extension PostRepository {
    
    private func getAllPosts() -> Observable<[TextResponse]> {
        return apiProvider.rx.request(.posts)
            .map { response in
                let decoder = JSONDecoder()
                return try decoder.decode([TextResponse].self, from: response)
            }
    }
}
