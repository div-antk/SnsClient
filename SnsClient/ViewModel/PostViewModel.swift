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
        
        var event: Observable<String> { return
            onPostButton.flatMap(self.postText) { event in
                PostRepository.postText(text: event)
            }
        }

        
        let onPostButton = PublishRelay<Void>()
        onPostButton.withLatestFrom(postText) {
            PostRepository.postText(text: postText)
        }
       
        
        onPostButton.subscribe(onNext: { postText in
            print(postText)
            PostRepository.postText(text: postText)
        }).disposed(by: disposeBag)
            
        
    }
    
//    func postpostText() {
//        print("(´・ω・｀)" )
////        onPostButtonStream.onNext(postText)
//        onPostButtonStream.subscribe(onNext: { postText in
//            PostRepository.postText(text: postText)
//        }).disposed(by: disposeBag)
//
////        onPostButtonStream.onNext({ event in
////            PostRepository.postText(text: event)
////        })
//    }
}

extension PostViewModel: PostViewModelType {
    var inputs: PostViewModelInputs { return self }
    var output: PostViewModelOutputs { return self }
}
