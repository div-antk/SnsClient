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
                let decoder = JSONDecoder()
                return try decoder.decode([Text].self, from: response.data)
            }.asObservable()
    }
    
    static func postText(text: String) -> () {
        apiProvider.rx.request(.postText(text: text))
            .map { response -> PostText? in
                print("(,,ﾟДﾟ)", response)
                let decoder = JSONDecoder()
                return try? decoder.decode(PostText.self, from: response.data)
            }.asObservable()
    
//    static func postText(text: String) -> () {
//        apiProvider.rx.request(.postText(text: text))
//            .map { response -> PostText? in
//                return try? JSONDecoder().decode(PostText.self, from: response.data)
//            }.subscribe(onSuccess: { response in
//                if let unwrappedResponse = response {
//                    print(unwrappedResponse)
//                } else {
//                    print("エラー")
//                }
//            }, onError: { error in
//                print(error)
//            })
//            .disposed(by: disposeBag)
    }
    
//    static func postText(text: String) -> () {
//
//        apiProvider.rx.request(.postText(text: text))
//            .subscribe({ event in
//                switch event {
//                case .success(let response):
//                    do {
//                        let data = try JSONDecoder().decode(PostText.self, from: response.data)
//                        return data
//                    }
//                case .error(let error):
//                    print(error)
//                }
//            })
//    }

}
