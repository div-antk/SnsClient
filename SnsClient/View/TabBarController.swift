//
//  TabBarController.swift
//  SnsClient
//
//  Created by Takuya Ando on 2021/07/25.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = MainViewController()
        let userVC = UIViewController()
        let postVC = UIViewController()
        
        setViewControllers([
            homeVC,
            postVC,
            userVC
        ], animated: true)
    }
}
