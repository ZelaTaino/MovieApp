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
    private var actors: String?
    private var description: String?
    private var duration: String?
    
    init(movieTitle: String, moviePoster: String, movieYear: String){
        title = movieTitle
        poster = moviePoster
        year = movieYear
    }
    
    func setDetails(movieScore: String, movieRating: String, movieActors: String, movieDescription: String, movieDuration: String) {
        score = movieScore
        rating = movieRating
        actors = movieActors
        description = movieDescription
        duration = movieDuration
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getPoster() -> UIImage {
        return DataHandler.getImage(path: poster)
    }
    
    func getYear() -> String {
        return year
    }
}
