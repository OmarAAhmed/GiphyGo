//
//  FeedViewController.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 07/04/2021.
//

import Foundation
import UIKit
class FeedViewController: UIViewController, UICollectionViewDelegateFlowLayout {

    
 

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var gifs = [GifModel]()
    
    // MARK: Outlets
    
    // MARK: Variables

    
    // MARK: View Configurations
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "GifCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GifCollectionViewCell")
        NetworkManager.shared.fetchGifs(endPoint: Endpoints.trending.rawValue, parameters: ["api_key": NetworkManager.shared.getAPIKey()]){ [weak self] (pics, count) in
            self?.gifs = pics
            self?.collectionView.reloadData()
    }



    func fetchRecipes() {

   }

    // MARK: Collection View Configurations
  


   

}
}


extension FeedViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.bounds.size.width - 12)
        let cellHeight = cellWidth * 1.25
        return CGSize(width: cellWidth, height: cellHeight)
    }

     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
}

extension FeedViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifCollectionViewCell",for: indexPath) as! GifCollectionViewCell
        cell.configure(gifs[indexPath.row] )
        return cell
    }
    
}


