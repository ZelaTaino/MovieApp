//
//  FirstViewController.swift
//  MovieSearchApp
//
//  Created by Glizela Taino on 2/28/17.
//  Copyright © 2017 Glizela Taino. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var movieArray = [Movie]()
    var cellSelected = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ aSearchBar: UISearchBar) {
        aSearchBar.text = ""
        searchBar(aSearchBar, textDidChange: "")
        aSearchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieArray.removeAll()
        let newSearchText = searchText.replacingOccurrences(of: " ", with: "+")
        DispatchQueue.global().async {
            let json = DataHandler.getJSON(path: "http://www.omdbapi.com/?s=\(newSearchText)")
            DispatchQueue.main.async {
                self.createMovies(json: json)
                self.collectionView.reloadData()
            }
        }
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

