//
//  FirstViewController.swift
//  MovieSearchApp
//
//  Created by Glizela Taino on 2/28/17.
//  Copyright © 2017 Glizela Taino. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    let sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    let itemsPerRow: CGFloat = 3
    var spinner = UIActivityIndicatorView()
    var movieArray = [Movie]()
    var arrangedArray = [[Movie]]()
    var typeArray = [String]()
    var cellSelected = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        
        let frame = CGRect(x: 0, y: 0, width: 37, height: 37)
        spinner = UIActivityIndicatorView(frame: frame)
        spinner.center.x = view.center.x
        spinner.center.y = view.frame.size.height / 4.0
        spinner.hidesWhenStopped = true
        spinner.activityIndicatorViewStyle = .gray
        collectionView.addSubview(spinner)
        
    }
    
    func arrangeMovieByType(movieList: [Movie]){
        for t in typeArray{
            var list = [Movie]()
            for aMovie in movieList{
                if aMovie.getType() == t{
                    list.append(aMovie)
                }
            }
            arrangedArray.append(list)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        spinner.startAnimating()
        movieArray.removeAll()
        arrangedArray.removeAll()
        typeArray.removeAll()
        collectionView.reloadData()
        let newSearchText = searchBar.text?.replacingOccurrences(of: " ", with: "+")
        DispatchQueue.global().async {
            let json = DataHandler.getJSON(path: "http://www.omdbapi.com/?s=\(newSearchText!)")
            var secondJson:JSON = []
            if json["totalResults"].intValue > 10 {
                secondJson = DataHandler.getJSON(path: "http://www.omdbapi.com/?s=\(newSearchText!)&page=2")
            }
            DispatchQueue.main.async {
                self.createMovies(json: json)
                if json["totalResults"].intValue > 10 {
                    self.createMovies(json: secondJson)
                }
                self.collectionView.reloadData()
                if json["Response"] != "False"{
                    searchBar.endEditing(true)
                }
                self.spinner.stopAnimating()
                self.arrangeMovieByType(movieList: self.movieArray)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrangedArray[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        let aMovie = arrangedArray[indexPath.section][indexPath.row]
        cell.setTitle(title: aMovie.getTitle())
        cell.setPosterImage(image: aMovie.getPoster())
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return typeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInset.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = 41.0/(27.0/widthPerItem) // maintaining poster ratio based on width
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInset.left
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        if !typeArray.isEmpty {
            let frame = CGRect(x: sectionInset.left, y: 0, width: header.frame.size.width, height: header.frame.size.height)
            let label = UILabel(frame: frame)
            label.font = label.font.withSize(14)
            label.text = typeArray[indexPath.section].uppercased()
            var view = header.subviews
            if !view.isEmpty {
                view[0].removeFromSuperview()
            }
            header.addSubview(label)
        }
        return header
    }
    
    private func createMovies(json: JSON) {
        for aJson in json["Search"].arrayValue{
            let movieTitle = aJson["Title"].stringValue
            let moviePoster = aJson["Poster"].stringValue
            let movieYear = aJson["Year"].stringValue
            let movieType = aJson["Type"].stringValue
            let aMovie = Movie(movieTitle: movieTitle, moviePoster: moviePoster, movieYear: movieYear, movieType: movieType)
            movieArray.append(aMovie)
            typeArray.append(movieType)
        }
        typeArray = Array(Set(typeArray))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueMovieDetails"{
            let nextVC = segue.destination as! MovieDetailViewController
            let indexPath = collectionView.indexPathsForSelectedItems
            let index = indexPath?[0]
            nextVC.aMovie = arrangedArray[(index?.section)!][(index?.row)!]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

