//
//  FeedPresenter.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 08/04/2021.
//

import Foundation


class FeedPresenter{
    var gifs = [GifModel]()
    var offset = 0
    var limit = 10
    var searchIsActive = false
    var selectedGif: GifModel!
    var query = ""
    var parameters = [String: String]()
    
    func fetchGifs(offset: Int, completion:@escaping  ()->()){
        self.offset = offset
        setParameters()
        if !searchIsActive{
            NetworkManager.shared.fetchGifs(endPoint: Endpoints.trending.rawValue, parameters: parameters , shouldRefresh: false){ [weak self] (pics, count) in
                self?.gifs.append(contentsOf: pics)
                completion()
            }} else {
                NetworkManager.shared.fetchGifs(endPoint: Endpoints.trending.rawValue, parameters: parameters, shouldRefresh: false){[weak self] (pics, count) in
                    self?.gifs.append(contentsOf: pics)
                    completion()
                }
            }
    }
    
    func setParameters(){
        if searchIsActive{
        parameters = ["api_key": NetworkManager.shared.getAPIKey(), "rating": UserDefaults.standard.object(forKey: "ContentRating") as! String, "offset": "\(offset)", "limit":"\(limit)", "q": query, "lang" :UserDefaults.standard.object(forKey: "Country") as! String]
        }else {
        parameters = ["api_key": NetworkManager.shared.getAPIKey(), "rating": UserDefaults.standard.object(forKey: "ContentRating") as! String, "offset": "\(offset)", "limit":"\(limit)"]
        }
    }
    
    func searchForGifs(keyword: String,completion:@escaping  ()->()){
        searchIsActive = true
        query = keyword
        setParameters()
        NetworkManager.shared.fetchGifs(endPoint: Endpoints.search.rawValue, parameters:parameters){ [weak self] (pics, count) in
            self?.gifs = pics
            
            self?.gifs.sort{
                (lhs,rhs) in
                return lhs < rhs
            }
            completion()
        }
    }
    
    func reload(){
        gifs.removeAll()
        offset = 0
    }
}
