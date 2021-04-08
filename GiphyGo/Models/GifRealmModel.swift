//
//  GifRealmModel.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 08/04/2021.
//

import Foundation
import RealmSwift

class GifRealmModel: Object{
    
    @objc dynamic var gifID: String = ""
    
    
    func mapToModel(_ gif: GifModel){
        self.gifID = gif.id ?? ""
    }
}
