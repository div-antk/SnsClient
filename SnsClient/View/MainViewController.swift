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

class MainViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private var postViewModel: PostViewModel!
    
    private var posts: [Post]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 50
        
        let nib = UINib(nibName: PostTableViewCell.reusableIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PostTableViewCell.reusableIdentifier)
        
        postViewModel = PostViewModel()
        
        postViewModel.output.posts
            .asObservable().subscribe { [weak self] in
                self?.posts = $0.element?.reversed()
                self?.tableView.reloadData()
            }.disposed(by: disposeBag)
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reusableIdentifier, for: indexPath) as! PostTableViewCell
        cell.postLabel?.text = posts?[indexPath.row].text
        cell.timeLabel?.text = posts?[indexPath.row]._created_at
        
        return cell
    }
}

