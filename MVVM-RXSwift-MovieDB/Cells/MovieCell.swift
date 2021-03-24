//
//  MovieCell.swift
//  MVVM-RXSwift-MovieDB
//
//  Created by Ganang Arief Pratama on 16/03/21.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    
    static let reuseIdentifier = "MOVIE_CELL_ID"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .systemBlue
        label.numberOfLines = 3
        
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 4
        
        return label
    }()
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    func setupViews() {
        setupInterfaceComponent()
        setupConstraint()
    }
    
    func setupInterfaceComponent() {
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(ratingLabel)
        addSubview(overviewLabel)
    }
    
    func setupConstraint() {
        posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        posterImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 4).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        
        overviewLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 16).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    }
    
    func configure(viewModel: MovieViewViewModel) {
        titleLabel.text = viewModel.title
        overviewLabel.text = viewModel.overview
        ratingLabel.text = viewModel.rating
        posterImageView.kf.setImage(with: viewModel.posterURL)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
