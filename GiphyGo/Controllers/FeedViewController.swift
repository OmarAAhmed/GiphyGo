//
//  FeedViewController.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 07/04/2021.
//

import Foundation
import UIKit

class FeedViewController: UIViewController, UICollectionViewDelegateFlowLayout {
   
    // MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Variables
    var presenter = FeedPresenter()
    var refreshControl:UIRefreshControl!
    
    
    // MARK: View Configurations
    override func viewWillAppear(_ animated: Bool) {
    }
    
     func fetchGifs() {
        presenter.fetchGifs {
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "GifCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GifCollectionViewCell")
    }
    
    fileprivate func configureSearchBar() {
        searchBar.delegate = self
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
    }
    
    fileprivate func configureRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView!.addSubview(refreshControl)
    }
    func configureUIComponents(){
        configureCollectionView()
        configureSearchBar()
        configureRefreshControl()
    }
    override func viewDidLoad() {
        configureUIComponents()
        fetchGifs()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserViewController{
            destination.user = presenter.selectedGif.user
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
        presenter.selectedGif = presenter.gifs[indexPath.row]
        if presenter.selectedGif.user != nil{
        performSegue(withIdentifier: "UserProfileSegue", sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == presenter.gifs.count - 1 {
            NetworkManager.shared.fetchGifs(endPoint: Endpoints.trending.rawValue, parameters: ["api_key": NetworkManager.shared.getAPIKey(), "rating": UserDefaults.standard.object(forKey: "ContentRating") as! String, "offset": "\(presenter.offset + 50)"], shouldRefresh: false){ [weak self] (pics, count) in
                self?.presenter.offset += 50
                self?.presenter.gifs.append(contentsOf: pics)
                self?.collectionView.reloadData()
                
            }
        }
    }
    
    @objc func refresh(){
        reload()
        self.refreshControl.endRefreshing()
    }
    
}

extension FeedViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.gifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifCollectionViewCell",for: indexPath) as! GifCollectionViewCell
        cell.configure(presenter.gifs[indexPath.row] )
        return cell
    }
    
}


extension FeedViewController: ReloadDataProtocol{
    func reload() {
        presenter.gifs.removeAll()
        fetchGifs()
        self.collectionView.reloadData()
    }
}


extension FeedViewController: UISearchBarDelegate{

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        NetworkManager.shared.fetchGifs(endPoint: Endpoints.search.rawValue, parameters: ["api_key": NetworkManager.shared.getAPIKey(), "rating": UserDefaults.standard.object(forKey: "ContentRating") as! String, "q": searchBar.text ?? ""]){ [weak self] (pics, count) in
            self?.presenter.gifs = pics
            self?.collectionView.reloadData()
        }
    }
}
