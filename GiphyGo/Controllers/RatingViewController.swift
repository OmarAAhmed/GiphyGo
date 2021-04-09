//
//  RatingViewController.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 07/04/2021.
//

import Foundation
import UIKit


enum Ratings: String, CaseIterable{
    case g
    case pg
    case pg13 =  "pg-13"
    case R
}
class RatingViewController: UITableViewController{
    
    var delegate : PageViewControllerNavigation!
    
    override func viewDidLoad() {
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ratingCell")!
        cell.textLabel?.text = Ratings.allCases[indexPath.row].rawValue
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.setValue(Ratings.allCases[indexPath.row].rawValue, forKey: "ContentRating")
        delegate.next(viewController: self)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}


