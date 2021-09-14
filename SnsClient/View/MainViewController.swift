//
//  MainViewController.swift
//  SnsClient
//
//  Created by Takuya Ando on 2021/07/19.
//

import UIKit
import RxSwift
import RxCocoa
import Instantiate
import InstantiateStandard
import PKHUD

class MainViewController: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private var postViewModel: PostViewModel!
    
    private var posts: [Text]?
//    private var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 50
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(MainViewController.refresh(sender:)), for: .valueChanged)
        
        let nib = UINib(nibName: PostTableViewCell.reusableIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PostTableViewCell.reusableIdentifier)
        
        /*
         「ルートVCではSwift UIApplication.shared.keyWindowがnilであるため、ビューを手動で指定するか、viewDidAppearにHUDを表示する必要がある」と説明しました。
         とにかく、以前に試したことがなかった理由はありません。解決策は、show()メソッドを呼び出すときに引数を追加することでした。
         */
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show(onView: view)
        //        HUD.show(.progress)
        getPostData()
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.getPostData()
            self?.tableView.refreshControl?.endRefreshing()
            self?.tableView.reloadData()
        }
    }
    
    func getPostData() {
        HUD.hide()
        postViewModel = PostViewModel()
        
        postViewModel.output.posts
            .asObservable().subscribe { [weak self] in
                self?.posts = $0.element?.reversed()
                self?.tableView.reloadData()
            }.disposed(by: disposeBag)
    }
    
//    func getUserData(id: String) {
//
//        postViewModel = PostViewModel()
//
//        postViewModel.inputs.userId.onNext(id)
//
//        postViewModel.output.user
//            .asObservable().subscribe { [weak self] in
//                self?.user = $0.element
//                self?.tableView.reloadData()
//            }.disposed(by: disposeBag)
//    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reusableIdentifier, for: indexPath) as! PostTableViewCell
        
        cell.postLabel?.text = posts?[indexPath.row].text
        
//        if let id = posts?[indexPath.row]._user_id {
//            getUserData(id: id)
//        }
//
//        cell.nameLabel.text = self.user?.name
        
        if let createdAt = posts?[indexPath.row]._created_at {
            let date = DateUtil.dateFromString(string: createdAt)
            cell.timeLabel.text = DateUtil.stringFromDate(date: date, format: "yyyy年MM月dd日 HH時mm分ss秒")
        }
        
        return cell
    }
}

