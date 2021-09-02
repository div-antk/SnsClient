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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 後述
        postViewModel = PostViewModel()
        
        // orEmptyというプロパティを使うとString?をStringに変換してくれる
        postTextField.rx.text.orEmpty
            // 前述でVMを初期化しないとnilになってしまう
            .bind(to: postViewModel.inputs.postText)
            .disposed(by: disposeBag)
        
        // ストリームに返すためにObservableのインスタンスを作って返ってきた型を<>で返す（もしくはシングル）
        // シングルだと都度都度subscribe
        // flatmapでRepositoryを呼ぶ
        // SuccessかErrorが返る
        // コールバックではなくストリーム
        postButton.rx.tap
            .subscribe(onNext: { [postViewModel] in
                postViewModel?.inputs.onPostButton
            }).disposed(by: disposeBag)
        
    }
}
