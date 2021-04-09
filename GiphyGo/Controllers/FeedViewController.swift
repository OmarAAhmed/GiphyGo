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
    var refreshControl: UIRefreshControl!
    
    
    // MARK: LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        reload()
    }
    
    
    override func viewDidLoad() {
        configureUIComponents()
    }
    
    // MARK:  Views Configurations
    
    func configureUIComponents(){
        configureCollectionView()
        configureSearchBar()
        configureRefreshControl()
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "GifCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GifCollectionViewCell")
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
    }
    
    func configureRefreshControl() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView!.addSubview(refreshControl)
    }
    
    // MARK: Data Request
    func fetchGifs() {
        presenter.fetchGifs(offset: presenter.offset + presenter.limit){
            self.collectionView.reloadData()
        }
    }
    
    // MARK: Selectors
    @objc func refresh(){
        presenter.offset = 0
        presenter.searchIsActive = false
        presenter.gifs.removeAll()
        searchBar.text?.removeAll()
        reload()
        self.refreshControl.endRefreshing()
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UserViewController{
            destination.user = presenter.selectedGif.user
        }
    }
}


// MARK: Collection View Delegate Configurations
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
            presenter.fetchGifs(offset: presenter.offset + presenter.limit){
                self.collectionView.reloadData()
            }
        }
    }
}


// MARK: Collection View Data Source Configuration
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

// MARK: Search Bar Delegate Configuration
extension FeedViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        presenter.searchForGifs(keyword: searchBar.text ?? ""){
            self.collectionView.reloadData()
        }
    }
}

// MARK: Protocol Conformation
extension FeedViewController: ReloadDataProtocol{
    func reload() {
        fetchGifs()
        self.collectionView.reloadData()
    }
}


