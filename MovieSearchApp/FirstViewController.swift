//
//  FirstViewController.swift
//  MovieSearchApp
//
//  Created by Glizela Taino on 2/28/17.
//  Copyright © 2017 Glizela Taino. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var movieArray = [Movie]()
    var cellSelected = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        let json = DataHandler.getJSON(path: "http://www.omdbapi.com/?s=salt&y=&plot=full")
        createMovies(json: json)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        //get a movie
        let aMovie = movieArray[indexPath.row]
        cell.setTitle(title: aMovie.getTitle())
        cell.setPosterImage(image: aMovie.getPoster())
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    private func createMovies(json: JSON) {
        
        for aJson in json["Search"].arrayValue{
            let movieTitle = aJson["Title"].stringValue
            let moviePoster = aJson["Poster"].stringValue
            let movieYear = aJson["Year"].stringValue
            let aMovie = Movie(movieTitle: movieTitle, moviePoster: moviePoster, movieYear: movieYear)
            movieArray.append(aMovie)
        }
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        cellSelected = indexPath.row
////        self.performSegue(withIdentifier: "segueMovieDetails", sender: nil)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueMovieDetails"{
            let nextVC = segue.destination as! MovieDetailViewController
            let indexPath = collectionView.indexPathsForSelectedItems
            let index = indexPath?[0]
            nextVC.aMovie = movieArray[(index?.row)!]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

