//
//  ReviewsTableViewController.swift
//  MovieSearchApp
//
//  Created by Glizela Taino on 3/7/17.
//  Copyright © 2017 Glizela Taino. All rights reserved.
//

import UIKit

class ReviewsTableViewController: UITableViewController {
    
    var names = ["Bob", "Zela"]
    var reviewsArray = ["Cool", "Before Nemo, a long ago another child got lost in the open ocean...\r\n\r\nWhoa! 200 million dollar film, 1 billion box office collections worldwide. The 27th film to do that so and the 5th animation film. This sequel was made after 13 years, surely a long gab, but 'Finding Nemo' was one of my favourite animations, tell me who does not love it those who love animation. Nevertheless, I liked the idea of having a sequel, but I scared it would go to flop terribly. Now, after watching this, I totally stunned. This is not a greatest animation ever made, but the way the screenplay handled, along with other stuffs, this makes one of the best among its kind.\r\n\r\nFirstly, when I heard the sequel's title, it made me laugh. Like, whaaaat? Once again the story is going to repeat. I did not think it would bring a big change. Actually, it was a different tale, especially I was not expecting it to be emotional. Tell me how many tearjerker-animation you have seen. Once again the Disney-Pixar jointly did it. I think appreciation must go to the director who also made the original film. Great casting too, I mean the voice- over artists."]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        tableView.estimatedRowHeight = 78
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reviewsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewTableViewCell
        cell.username.text = names[indexPath.row]
        cell.comment.text = reviewsArray[indexPath.row]
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
