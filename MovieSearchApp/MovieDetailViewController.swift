//
//  MovieDetailViewController.swift
//  MovieSearchApp
//
//  Created by Glizela Taino on 2/28/17.
//  Copyright © 2017 Glizela Taino. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var rated: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var year: UILabel!
    
    var aMovie: Movie!
    var favoritesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        favoritesArray = defaults.object(forKey: "favorites") as! [String]
        
        self.title = aMovie.getTitle()
        poster.image = aMovie.getPoster()
        year.text = "Released: \(aMovie.getYear())"
        
        let searchTitle = aMovie.getTitle().replacingOccurrences(of: " ", with: "+")
        let json = DataHandler.getJSON(path: "http://www.omdbapi.com/?t=\(searchTitle)&plot=full")
        print("\(json)")
        addToMovie(json: json)
    }
    
    func addToMovie(json: JSON) {
        score.text = "Score: \(json["imdbRating"].stringValue)/10"
        rated.text = "Rated: \(json["Rated"].stringValue)"
    }

    @IBAction func addToFavoritesPressed(_ sender: UIButton) {
        favoritesArray.append(aMovie.getTitle())
        
        let defaults = UserDefaults.standard
        defaults.set(favoritesArray, forKey: "favorites")
    }
    
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
