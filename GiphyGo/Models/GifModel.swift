//
//  GifModel.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 07/04/2021.
//

import Foundation
import ObjectMapper

class GifModel: Mappable{

    
    
    var id: String?
    var url: String?
    var rating: String?
    var title: String?
    var importDateTime: String?
    var trendingDateTime: Date?
    var user: UserModel?
    var width: String?
    var height: String?
    

    
    func mapping(map: Map) {
        id <- map["id"]
        url <- map["images.downsized.url"]
        rating <- map["rating"]
        title <- map["title"]
        importDateTime <- map["import_datetime"]
        trendingDateTime <- map["trending_datetime"]
        width <- map["images.downsized.width"]
        height <- map["images.downsized.height"]

    }
    
    required init?(map: Map) {
        
    }
    
}
