//
//  CountryManager.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 07/04/2021.
//

import Foundation

class CountriesManager {
    let countryCodes = ["us", "es", "pt", "id", "fr", "eg", "tr", "it", "de", "tr", "th", "jp", "ru", "pl", "nl", "ro", "hu", "sv", "bn", "tl"]
    
    func getCountryCodeAndFlag(country:String)->String{
          let base : UInt32 = 127397
              var s = ""
              for v in country.unicodeScalars {
                  s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
              }
              return String(s)
    }
}
