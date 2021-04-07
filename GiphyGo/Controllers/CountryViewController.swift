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
    var delegate : PageViewControllerNavigation!
    
    override func viewDidLoad() {
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flagCell")!
        let flag = manager.getCountryCodeAndFlag(country: manager.countryCodes[indexPath.row].uppercased())
        let name = manager.countryCodes[indexPath.row].uppercased()
        cell.textLabel?.text = "\(flag) \(name)"
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.setValue(manager.countryCodes[indexPath.row], forKey: "Country")
        delegate.next(viewController: self)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.countryCodes.count
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
