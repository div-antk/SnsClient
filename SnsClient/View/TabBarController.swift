//
//  TabBarController.swift
//  SnsClient
//
//  Created by Takuya Ando on 2021/07/25.
//

import UIKit

class TabBarController: UITabBarController {
    
    var firstVC: UIViewController?
    var secondVC: UIViewController?
    var thirdVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var vcs: [UIViewController] = []
        
        firstVC = MainViewController.instantiate()
        secondVC = PostViewController.instantiate()
        thirdVC = UIViewController()
        
        guard let firstVC = firstVC,
              let secondVC = secondVC,
              let thirdVC = thirdVC
        else { return }
        
        vcs.append(firstVC)
        vcs.append(secondVC)
        vcs.append(thirdVC)
        
        self.setViewControllers(vcs, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let firstVC = firstVC,
              let secondVC = secondVC,
              let thirdVC = thirdVC
        else { return }
        
        firstVC.tabBarItem = UITabBarItem(title: "ホーム", image: UIImage(systemName: "house.fill"), tag: 0)
        secondVC.tabBarItem = UITabBarItem(title: "投稿", image: UIImage(systemName: "square.and.pencil"), tag: 0)
        thirdVC.tabBarItem = UITabBarItem(title: "ユーザ情報", image: UIImage(systemName: "person.fill"), tag: 0)
        
    }
}
