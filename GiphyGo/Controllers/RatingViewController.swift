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
    
    @IBOutlet weak var instructionLabel: UILabel!
    var delegate : PageViewControllerNavigationProtocol!
    
    override func viewDidLoad() {
        configureFontSize(label: instructionLabel)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ratingCell")!
        cell.textLabel?.text = Ratings.allCases[indexPath.row].rawValue
        configureFontSize(label: cell.textLabel!)
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
    
    func configureFontSize(label: UILabel) {
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if label == instructionLabel{
            label.font = label.font.withSize(24)
            } else {
                label.font = label.font.withSize(20)
            }
        }
    }
}


