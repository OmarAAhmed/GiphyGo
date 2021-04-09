//
//  NetworkManager.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 07/04/2021.
//

import Foundation
import Alamofire
import ObjectMapper

class NetworkManager{
    
    private var baseURL = "https://api.giphy.com/v1/gifs"
    private var apiKey = "ElLZJsFs0jgjsdAY4UXQW9TM1M9IXDJ0"
    
    public static let shared: NetworkManager =  NetworkManager()
    
    

    
    func getAPIKey()-> String{
    return self.apiKey
    }
    
    func fetchGifs(endPoint: String, parameters: [String:String], shouldRefresh: Bool = true ,completion: @escaping ([GifModel], Int)->()){
        
        AF.request(baseURL+endPoint, method: .get, parameters: parameters).responseJSON{ [weak self](response)
            in
            var totalCount = 0
            var gifsArray = [GifModel]()
            if let result  = response.value as? Dictionary<String, Any>{
                if let returnedTotalCount = result["totalResults"] as? Int{
                totalCount = returnedTotalCount
                }
                if let gifs = result["data"] as? [Dictionary<String,Any>] {
                    
                    if !gifs.isEmpty{
                        for gif in gifs {
                            let modeledgifs = Mapper<GifModel>().map(JSONObject: gif)
                            gifsArray.append(modeledgifs!)
                        }
                    }
                }
            }
            completion(gifsArray, totalCount)
        }
    }
}

enum Endpoints: String{
    case trending = "/trending"
    case search = "/search"
}
