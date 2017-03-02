//
//  MovieCollectionViewCell.swift
//  MovieSearchApp
//
//  Created by Glizela Taino on 3/1/17.
//  Copyright © 2017 Glizela Taino. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var posterImg: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    
    func setPosterImage(image: UIImage) {
        posterImg.image = image
    }
    
    func setTitle(title: String) {
        movieTitle.text = title
    }
    
}
