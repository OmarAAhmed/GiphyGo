//
//  FeedViewController.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 07/04/2021.
//

import Foundation
import UIKit
class FeedViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var searchBar: UISearchBar!
    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Variables
    var gifs = [GifModel]()
    var offset = 0
    var refreshControl:UIRefreshControl!
    var selectedGif: GifModel!
    // MARK: View Configurations
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        
        textFieldInsideSearchBar?.textColor = UIColor.white
        
        collectionView.register(UINib(nibName: "GifCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GifCollectionViewCell")
        NetworkManager.shared.fetchGifs(endPoint: Endpoints.trending.rawValue, parameters: ["api_key": NetworkManager.shared.getAPIKey(), "rating": UserDefaults.standard.object(forKey: "ContentRating") as! String]){ [weak self] (pics, count) in
            self?.gifs = pics
            self?.collectionView.reloadData()
        }
        
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
}


extension FeedViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.bounds.size.width - 12) / 2
        let cellHeight = cellWidth * 1.25
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedGif = gifs[indexPath.row]
        if selectedGif.user != nil{
        performSegue(withIdentifier: "UserProfileSegue", sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == gifs.count - 1 {
            NetworkManager.shared.fetchGifs(endPoint: Endpoints.trending.rawValue, parameters: ["api_key": NetworkManager.shared.getAPIKey(), "rating": UserDefaults.standard.object(forKey: "ContentRating") as! String, "offset": "\(offset + 50)"], shouldRefresh: false){ [weak self] (pics, count) in
                self?.offset += 50
                self?.gifs.append(contentsOf: pics)
                self?.collectionView.reloadData()
                
            }
        }
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


