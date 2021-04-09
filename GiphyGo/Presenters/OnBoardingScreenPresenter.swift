//
//  OnBoardingScreenPresenter.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 09/04/2021.
//

import Foundation
import UIKit
class OnBoardingScreenPresenter{
    
    func navigateToTabBar(completion: @escaping ()->()){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarViewController
        UserDefaults.standard.setValue(true, forKey: "OnBoardingSuccess")
        UIApplication.shared.windows.first?.rootViewController = viewController
        completion()
    }
    func getCurrentStaggeViewController(stage: Int, sender: OnBoardingScreenViewController) -> UITableViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        switch stage{
        case 0:
            let viewController  = storyboard.instantiateViewController(withIdentifier: "CountryVC") as! CountryViewController
            viewController.delegate = sender
            return viewController
        default:
            let viewController =  storyboard.instantiateViewController(withIdentifier: "RatingVC") as! RatingViewController
            viewController.delegate = sender
            return viewController
        }
    }
}
