//
//  FavoritesViewController.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 08/04/2021.
//

import Foundation
import UIKit
import RealmSwift

class FavoritesViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: Outlets
 
    @IBOutlet weak var collectionView: UICollectionView!

    
    // MARK: Variables
    var gifs = [GifModel]()
    var favoritesString = ""
    var offset = 0
    var refreshControl:UIRefreshControl!
    var selectedGif: GifModel!
    // MARK: View Configurations
    override func viewWillAppear(_ animated: Bool) {
        reload()
    }
    
     func fetchGifs() {
        NetworkManager.shared.fetchGifs(endPoint: "", parameters: ["api_key": NetworkManager.shared.getAPIKey(), "rating": UserDefaults.standard.object(forKey: "ContentRating") as! String, "ids": favoritesString] ){ [weak self] (pics, count) in
            self?.gifs = pics
            self?.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "GifCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GifCollectionViewCell")
        
        self.refreshControl = UIRefreshControl()
        //   self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(viewDidLoad), for: .valueChanged)
        collectionView!.addSubview(refreshControl)
        // MARK: Collection View Configurations
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserViewController{
            destination.user = selectedGif.user
        }
    }
    
    func getFavorites(){
        let realm = try? Realm()
        let favoriteGifs = realm?.objects(GifRealmModel.self)
        favoritesString = (favoriteGifs?.map{ $0.gifID}.joined(separator: ",")) ?? ""
        
    }
    
    @objc func refresh(){
        reload()
    }
}


extension FavoritesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.bounds.size.width - 12) / 2
        let cellHeight = cellWidth * 1.25
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedGif = gifs[indexPath.row]
        if selectedGif.user != nil{
        performSegue(withIdentifier: "UserProfileFavoritesSegue", sender: self)
        }
    }

}

extension FavoritesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifCollectionViewCell",for: indexPath) as! GifCollectionViewCell
        cell.delegate = self
        cell.configure(gifs[indexPath.row] )
        return cell
    }
    
}

extension FavoritesViewController: ReloadDataProtocol{
    func reload() {
        getFavorites()
        fetchGifs()
        self.refreshControl.endRefreshing()
        self.collectionView.reloadData()
    }
}

protocol ReloadDataProtocol {
    func reload()
}
