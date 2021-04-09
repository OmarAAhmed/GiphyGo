//
//  CountryViewController.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 07/04/2021.
//

import Foundation
import UIKit

class CountryViewController: UITableViewController{
    
    var manager = CountriesManager()
    var delegate : PageViewControllerNavigationProtocol!
    @IBOutlet weak var instructionLabel: UILabel!
    
    override func viewDidLoad() {
        configureFontSize(label: instructionLabel)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flagCell")!
        let flag = manager.getCountryCodeAndFlag(country: manager.countryCodes[indexPath.row].uppercased())
        let name = manager.countryCodes[indexPath.row].uppercased()
        cell.textLabel?.text = "\(flag) \(name)"
        configureFontSize(label: cell.textLabel!)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var country = manager.countryCodes[indexPath.row]
        switch country{
        case "us":
            country = "en"
        case "jp":
            country = "ja"
        case "eg":
            country = "ar"
        default:
            break
        }
        UserDefaults.standard.setValue(country, forKey: "Country")
      
        delegate.next(viewController: self)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.countryCodes.count
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
