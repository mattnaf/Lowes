//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var titleString: String?
    var releaseDateString: String?
    var overviewString: String?
    var posterPathString: String?
    
    @IBOutlet weak var detailTitleLabel: UILabel!
    
    @IBOutlet weak var detailReleaseDateLabel: UILabel!
    
    @IBOutlet weak var detailOverviewLabel: UILabel!
    
    @IBOutlet weak var detailPosterImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTitleLabel.text = titleString ?? ""
        detailReleaseDateLabel.text = releaseDateString ?? ""
        detailOverviewLabel.text = overviewString ?? ""
        fetchImage()
    }
    
    private func fetchImage() {
        
        guard let path = posterPathString, let url = URL(string: "https://image.tmdb.org/t/p/w500/\(path)" ) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data ,_,error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.detailPosterImage.image = UIImage(data: data)
            }
        }
        task.resume()
        
    }
}
