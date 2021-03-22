//
//  ViewController.swift
//  MVVM-RXSwift-MovieDB
//
//  Created by Ganang Arief Pratama on 15/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class MovieListViewController: UIViewController {
    
    var movieListViewViewModel: MovieListViewViewModel!
    let disposeBag = DisposeBag()
    
    let movieSegmentedControl: UISegmentedControl = {
        let items = ["Now Playing", "Popular", "Upcoming"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        
        return segmentedControl
    }()
    
    lazy var movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        super.tabBarController?.title = "MOVIES"
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViews()
    }
    
    func setupViews() {
        setupViewModel()
        configureInterfaceComponent()
        configureConstraint()
        configureTableView()
    }
    
    func configureTableView() {
        movieTableView.tableFooterView = UIView()
        movieTableView.rowHeight = UITableView.automaticDimension
        movieTableView.estimatedRowHeight = 100
        movieTableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.reuseIdentifier)
    }
    
    func configureInterfaceComponent() {
        view.addSubview(movieSegmentedControl)
        view.addSubview(movieTableView)
    }
    
    func configureConstraint() {
        movieSegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        movieSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        movieSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        movieTableView.topAnchor.constraint(equalTo: movieSegmentedControl.bottomAnchor, constant: 16).isActive = true
        movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8).isActive = true
    }
    
}


// Handle setup RX
extension MovieListViewController {
    
    func setupViewModel() {
        movieListViewViewModel = MovieListViewViewModel(endpoint: movieSegmentedControl.rx.selectedSegmentIndex
                                                            .map { MovieEndPoint(index: $0) ?? .nowPlaying }
                                                            .asDriver(onErrorJustReturn: .nowPlaying)
                                                        , movieService: MovieProvider.shared)
        
        movieListViewViewModel.movies.drive(onNext: {[unowned self] (_) in
            self.movieTableView.reloadData()
        }).disposed(by: disposeBag)
        
//        movieListViewViewModel.isFetching.drive(activityIndicatorView.rx.isAnimating)
//            .disposed(by: disposeBag)
//        
//        movieListViewViewModel.error.drive(onNext: {[unowned self] (error) in
//            self.infoLabel.isHidden = !self.movieListViewViewModel.hasError
//            self.infoLabel.text = error
//        }).disposed(by: disposeBag)
    }
}


extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListViewViewModel.numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
        
        if let viewModel = movieListViewViewModel.viewModelForMovie(at: indexPath.row) {
            print(viewModel.title)
        }
                
        return cell
    }
    
}

