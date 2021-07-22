//
//  PostViewModel.swift
//  SnsClient
//
//  Created by Takuya Ando on 2021/07/21.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

protocol PostViewModelOutputs {
    var posts: Observable<[Post]> { get }
}

protocol PostViewModelType {
    var output: PostViewModelOutputs { get }
}

class PostViewModel: PostViewModelOutputs {
    
    let posts: Observable<[Post]>
    
    private let disposeBag = DisposeBag()
    private let provider = MoyaProvider<SnsAPI>()
    
    init() {
        let _posts = PublishRelay<[Post]>()
        self.posts = _posts.asObservable()
        
        PostRepository.getAllPosts()
            .subscribe(onNext: { response in
                print("(´・ω・｀)", response)
                _posts.accept(response)
            }).disposed(by: disposeBag)
    }
}

extension PostViewModel: PostViewModelType {
    var output: PostViewModelOutputs { return self}
}
