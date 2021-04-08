//
//  GifRealmModel.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 08/04/2021.
//

import Foundation
import RealmSwift

class GifRealmModel: Object{
    
    @objc var id: String = ""
    
    
    func mapToModel(_ gif: GifModel){
        self.id = gif.id ?? ""
    }
}
