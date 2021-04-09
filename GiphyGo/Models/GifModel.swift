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
    var trendingDateTime: String?
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
        user <- map["user"]

    }
    
    required init?(map: Map) {
        
    }
    
   class func converToDate(date: String)->Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let convertedDate = dateFormatter.date(from:date)!
        print(convertedDate)
        return convertedDate
    }
    
}

extension GifModel: Comparable{
    static func < (lhs: GifModel, rhs: GifModel) -> Bool {
        return self.converToDate(date: lhs.importDateTime!) < self.converToDate(date: rhs.importDateTime!)
    }
    
    static func == (lhs: GifModel, rhs: GifModel) -> Bool {
        return self.converToDate(date: lhs.importDateTime!) == self.converToDate(date: rhs.importDateTime!)
    }
}
