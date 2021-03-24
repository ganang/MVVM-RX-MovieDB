//
//  SegmentedControl+Extension.swift
//  MVVM-RXSwift-MovieDB
//
//  Created by Ganang Arief Pratama on 16/03/21.
//

import UIKit

extension UISegmentedControl {
    
    var endpoint: MovieEndPoint {
        switch self.selectedSegmentIndex {
        case 0: return .nowPlaying
        case 1: return .popular
        case 2: return .upcoming
        case 3: return .topRated
        default: fatalError()
        }
    }
}
