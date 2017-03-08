//
//  Review.swift
//  MovieSearchApp
//
//  Created by Glizela Taino on 3/7/17.
//  Copyright © 2017 Glizela Taino. All rights reserved.
//

import UIKit

class Review{
    var username: String
    var commentContent: String
    
    init(name: String, comment: String) {
        username = name
        commentContent = comment
    }
}
