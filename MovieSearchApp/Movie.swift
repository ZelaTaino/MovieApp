//
//  Movie.swift
//  MovieSearchApp
//
//  Created by Glizela Taino on 3/1/17.
//  Copyright © 2017 Glizela Taino. All rights reserved.
//

import UIKit

class Movie {
    
    private var title: String
    private var poster: String
    private var year: String
    private var score: String?
    private var rating: String?
    
    init(movieTitle: String, moviePoster: String, movieYear: String){
        title = movieTitle
        poster = moviePoster
        year = movieYear
    }
    
    func setDetails(movieScore: String, movieRating: String) {
        score = movieScore
        rating = movieRating
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getPoster() -> UIImage {
//        let json = JsonHandler.getJSON(path: poster)
        guard let url = URL(string: poster)else { return UIImage(named: "noPhoto.png")! }
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data)!
        } catch {
            return UIImage(named: "noPhoto.png")!
        }

        
//        guard let image = UIImage(named: poster) else{
//            return UIImage(named: "noPhoto.png")!
//        }
//        return image
    }
}
