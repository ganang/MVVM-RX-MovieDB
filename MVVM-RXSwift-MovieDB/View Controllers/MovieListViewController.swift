//
//  ViewController.swift
//  MVVM-RXSwift-MovieDB
//
//  Created by Ganang Arief Pratama on 15/03/21.
//

import UIKit

class MovieListViewController: UIViewController {
    
    let movieSegmentedControl: UISegmentedControl = {
        let items = ["NowPlaying", "Popular", "Upcoming"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        
        return segmentedControl
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        super.tabBarController?.title = "MOVIE"
        view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
    }
    
    func setupViews() {
        configureInterfaceComponent()
        configureConstraint()
    }
    
    func configureInterfaceComponent() {
        view.addSubview(movieSegmentedControl)
    }
    
    func configureConstraint() {
        movieSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        movieSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        movieSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }

}

