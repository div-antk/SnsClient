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

protocol PostViewModelInputs {
    var postText: AnyObserver<String> { get }
    var onPostButton: AnyObserver<Void> { get }
}

protocol PostViewModelOutputs {
    var posts: Observable<[Text]> { get }
}

protocol PostViewModelType {
    var inputs: PostViewModelInputs { get }
    var output: PostViewModelOutputs { get }
}

class PostViewModel: PostViewModelOutputs, PostViewModelInputs {
    
    // MARK: input
    let postText: AnyObserver<String>
    let onPostButton: AnyObserver<Void>
        
    // MARK: output
    let posts: Observable<[Text]>
    
    // MARK: other
    private let disposeBag = DisposeBag()
    private let provider = MoyaProvider<SnsAPI>()
    
    init() {
        let _posts = PublishRelay<[Text]>()
        self.posts = _posts.asObservable()
        
        let _postText = PublishRelay<String>()
        self.postText = AnyObserver<String>() { event in
            guard let text = event.element else { return }
            _postText.accept(text)
        }
        
        PostRepository.getAllPosts()
            .subscribe(onNext: { response in
                _posts.accept(response)
            })
            .disposed(by: disposeBag)
        
        let _onPostButton = PublishRelay<Void>()
        self.onPostButton = AnyObserver<Void>() { event in
            guard let event = event.element else { return }
            // 流れてきたイベントを留めておく
            _onPostButton.accept(event)
        }
        
        // textのPublishRelayとbuttonのPublishRelayを流す
        // .mapを使うとバリデーションの処理などを挟んだりできる
        _onPostButton.withLatestFrom(_postText)
            .subscribe(onNext: { text in
                print(text)
                // PostRepository.postText(text: text)
            }).disposed(by: disposeBag)
    }
}

extension PostViewModel: PostViewModelType {
    var inputs: PostViewModelInputs { return self }
    var output: PostViewModelOutputs { return self }
}
