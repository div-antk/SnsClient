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
    var posts: Observable<[Text]> { get }
}

protocol PostViewModelType {
    var output: PostViewModelOutputs { get }
}

class PostViewModel: PostViewModelOutputs {
    
    let posts: Observable<[Text]>
    
    private let disposeBag = DisposeBag()
    private let provider = MoyaProvider<SnsAPI>()
    
    init() {
        let _posts = PublishRelay<[Text]>()
        self.posts = _posts.asObservable()
        
        PostRepository.getAllPosts()
            .subscribe(onNext: { response in
                _posts.accept(response)
            }).disposed(by: disposeBag)
    }
}

extension PostViewModel: PostViewModelType {
    var output: PostViewModelOutputs { return self}
}
