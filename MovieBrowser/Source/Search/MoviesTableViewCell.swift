//
//  MoviesTableViewCell.swift
//  MovieBrowser
//
//  Created by matt nafarrete on 7/20/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieDateLabel: UILabel!
    

    @IBOutlet weak var movieVoteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
