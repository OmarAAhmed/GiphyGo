//
//  UserModel.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 07/04/2021.
//

import Foundation
import ObjectMapper

class UserModel: Mappable{
    
    var avatarUrl: String?
    var profileUrl: String?
    var username: String?
    var description: String?
    var instagramUrl: String?
    var isVerified: Bool?
  
    
    
    func mapping(map: Map) {
        avatarUrl <- map["avatar_url"]
        profileUrl <- map["profile_url"]
        username <- map["username"]
        description <- map["description"]
        instagramUrl <- map["instagram_url"]
        isVerified <- map["is_verified"]
    }
    
    required init?(map: Map) {
        
    }

    
}


