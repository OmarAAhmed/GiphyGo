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

    @IBOutlet weak var noDataView: UIView!
    
    // MARK: Variables
  
    var refreshControl:UIRefreshControl!
    var presenter = FavoritesPresenter()

    // MARK: View Configurations
     func showOrHideNoDataView() {
        if presenter.gifs.count > 0 {
            noDataView.isHidden = true
        } else {
            noDataView.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reload()

    }
    
     func fetchGifs() {
        presenter.fetchFavorites{
            self.collectionView.reloadData()
        }
    }
    
     func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "GifCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GifCollectionViewCell")
        collectionView!.addSubview(refreshControl)
    }
    
     func configureRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(viewDidLoad), for: .valueChanged)
        
    }
    
    override func viewDidLoad() {
        configureRefreshControl()
        configureCollectionView()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserViewController{
            destination.user = presenter.selectedGif.user
        }
    }
    
    func getFavorites(){
        let realm = try? Realm()
        let favoriteGifs = realm?.objects(GifRealmModel.self)
        presenter.favoritesString = (favoriteGifs?.map{ $0.gifID}.joined(separator: ",")) ?? ""
    }
    
    @objc func refresh(){
        reload()
        self.refreshControl.endRefreshing()
    }
}


extension FavoritesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.bounds.size.width - 12) / 2
        let cellHeight = cellWidth * 1.25
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.selectedGif = presenter.gifs[indexPath.row]
        if presenter.selectedGif.user != nil{
        performSegue(withIdentifier: "UserProfileFavoritesSegue", sender: self)
        }
    }

}

extension FavoritesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        showOrHideNoDataView()
        return presenter.gifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifCollectionViewCell",for: indexPath) as! GifCollectionViewCell
        cell.delegate = self
        cell.configure(presenter.gifs[indexPath.row] )
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

