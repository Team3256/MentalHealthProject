//
//  CensorMethods.swift
//  MentalHealthProject
//
//  Created by Rishi Wadhwa on 3/22/21.
//

import Foundation

class CensorMethods {
    
    static let cussWords = [
        "ass",
        "shit",
        "bitch",
        "fuck"
    ]
    
    static func stars(_ length: Int) -> String {
        var stars = ""
        
        for _ in 1...length {
            stars += "-"
        }
        
        return stars
    }
    
    static func censorPhrase(_ phrase: String) -> String{
        var newPhrase = phrase
        
        for i in cussWords {
            newPhrase = newPhrase.replacingOccurrences(of: "\(i)", with: "\(stars(i.count))")
        }
        
        return newPhrase
    }
    
}
