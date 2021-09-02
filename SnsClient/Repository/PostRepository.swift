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
    
    static func getAllPosts() -> Observable<[Text]> {
        return apiProvider.rx.request(.all)
            .map { response in
                print(response)
                let decoder = JSONDecoder()
                return try decoder.decode([Text].self, from: response.data)
            }.asObservable()
    }
    
    static func postText(text: String) -> () {
        apiProvider.rx.request(.postText(text: text))
            .map { response -> PostText? in
                let decoder = JSONDecoder()
                return try? decoder.decode(PostText.self, from: response.data)
            }.subscribe(onSuccess: { response in
                if let unwrappedResponse = response {
                    print(unwrappedResponse)
                } else {
                    // 投稿が成功してもここが呼ばれる
                    print("エラー")
                }
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
}
