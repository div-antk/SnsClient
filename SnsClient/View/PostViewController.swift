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
    
    var textSubject = BehaviorRelay<String?>(value: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTextField.rx.text.bind(to: textSubject)
            .disposed(by: disposeBag)
        
        textSubject
            .map { $0 }
            .bind(to: postButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}
