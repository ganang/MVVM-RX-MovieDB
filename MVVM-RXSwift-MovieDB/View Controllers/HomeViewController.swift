//
//  HomeViewController.swift
//  MVVM-RXSwift-MovieDB
//
//  Created by Ganang Arief Pratama on 15/03/21.
//

import UIKit

class HomeViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        
        configureTabbar()
    }
    
    func configureTabbar() {
        let intraDayVC = MovieListViewController()
        intraDayVC.tabBarItem = UITabBarItem.init(title: "Featured", image: UIImage(systemName: "star.fill"), selectedImage: UIImage(systemName: "star.fill"))
        
        let dailyVC = MovieListViewController()
        dailyVC.tabBarItem = UITabBarItem.init(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        
        let tabBarList = [intraDayVC, dailyVC]
        viewControllers = tabBarList
    }
}
