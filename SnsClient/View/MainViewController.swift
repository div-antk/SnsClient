//
//  MainViewController.swift
//  SnsClient
//
//  Created by Takuya Ando on 2021/07/19.
//

import UIKit
import Instantiate
import InstantiateStandard

class MainViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: PostTableViewCell.reusableIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PostTableViewCell.reusableIdentifier)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reusableIdentifier, for: indexPath) as! PostTableViewCell
        
        return cell
    }
}

