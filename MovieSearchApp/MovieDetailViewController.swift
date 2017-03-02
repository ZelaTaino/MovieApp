//
//  MovieDetailViewController.swift
//  MovieSearchApp
//
//  Created by Glizela Taino on 2/28/17.
//  Copyright © 2017 Glizela Taino. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, UIScrollViewDelegate{

    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var actors: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    var aMovie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitle.text = aMovie.getTitle()
        poster.image = aMovie.getPoster()
        year.text = aMovie.getYear()
        
        let json = DataHandler.getJSON(path: "http://www.omdbapi.com/?t=salt&plot=full")
        //addToMovie(json: json)
    }
    
    func addToMovie(json: JSON) {
        for aJson in json.arrayValue {
            score.text = aJson["imdbRating"].stringValue
            rating.text = aJson["Rated"].stringValue
            actors.text = aJson["Actors"].stringValue
            movieDescription.text = aJson["Plot"].stringValue
            duration.text = aJson["Runtime"].stringValue
        }
    }
    
    //pull movies full info and add to object
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
