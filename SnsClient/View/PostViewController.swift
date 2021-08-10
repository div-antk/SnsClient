//
//  PostViewController.swift
//  SnsClient
//
//  Created by Takuya Ando on 2021/07/28.
//

import UIKit
import RxSwift
import RxCocoa
import Instantiate
import InstantiateStandard

class PostViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet weak var postTextField: UITextField!
    @IBOutlet weak var postButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private var postViewModel: PostViewModel!
    
    var textSubject = PublishSubject<String?>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 後述
        postViewModel = PostViewModel()
        
        // orEmptyというプロパティを使うとString?をStringに変換してくれる
        postTextField.rx.text.orEmpty
            // 前述でVMを初期化しないとnilになってしまう
            .bind(to: postViewModel.inputs.postText)
            .disposed(by: disposeBag)
        
//        postButton.rx.tap
//            .map { [weak self] in
//                return self?.textSubject
//            }
//            .bind(to: postViewModel.postText)
//            
//        
//        textSubject
//            .map { $0 }
//            .bind(to: postButton.rx.isEnabled)
//            .subscribe(onNext)
////            .disposed(by: disposeBag)
    }
}
