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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    func setupViews() {
        setupInterfaceComponent()
        setupConstraint()
    }
    
    func setupInterfaceComponent() {
        
    }
    
    func setupConstraint() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
