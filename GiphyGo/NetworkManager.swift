//
//  NetworkManager.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 07/04/2021.
//

import Foundation
import Alamofire

class NetworkManager{
    private var baseURL = "api.giphy.com/v1/gifs"
    private var apiKey = "ElLZJsFs0jgjsdAY4UXQW9TM1M9IXDJ0"
    
}



enum Endpoints: String{
    case trending = "/trending"
    case search = "/search"
}
