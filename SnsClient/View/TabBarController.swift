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
        secondVC = UIViewController()
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
}
