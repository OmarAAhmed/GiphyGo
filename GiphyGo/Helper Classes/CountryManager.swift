//
//  CountryManager.swift
//  GiphyGo
//
//  Created by Omar Abdelaziz on 07/04/2021.
//

import Foundation

class CountriesManager {
//    let countryCodes = ["ae", "ar", "at", "au", "be", "bg", "br", "ca", "ch", "cn", "co", "cu", "cz", "de", "eg", "fr", "gb", "gr", "hk", "hu", "id", "ie", "il","in", "it", "jp", "kr", "lt", "lv", "ma", "mx", "my", "ng", "nl", "no" ,"nz" , "ph", "pl", "pt", "ro", "rs", "ru", "sa", "se", "sg", "si", "sk", "th", "tr", "tw", "ua", "us", "ve","za"]
    let countryCodes = ["us", "es", "pt", "id", "fr", "ar", "tr", "it", "de", "tr", "th", "jp", "ru", "pl", "nl", "ro", "hu", "sv", "bn", "tl"]
    
    func getCountryCodeAndFlag(country:String)->String{
          let base : UInt32 = 127397
              var s = ""
              for v in country.unicodeScalars {
                  s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
              }
              return String(s)
    }
}
