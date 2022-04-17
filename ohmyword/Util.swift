//
//  Util.swift
//  ohmyword
//
//  Created by paul beavers on 4/16/22.
//

import Foundation

var wordArray:[String] = ["HOUSE", "BOAST", "BOATS", "LOUSE", "ROAST",
    "HEIST", "FIEND", "FORAY", "ROYAL", "CLUES", "BLUES", "TOAST", "SCORE", "SCREW"]

func getNextWord() -> String {
    let number = arc4random_uniform(UInt32(wordArray.count))
    return wordArray[Int(number)]
}

func getNextWordArray() -> [String] {
    
    var winningWordArray:[String] = ["", "", "", "", ""]
    let nextWord = getNextWord()
    
    var idx:String.Index = nextWord.startIndex
    winningWordArray[0] = String(nextWord[idx])
    
    idx = nextWord.index(after: idx)
    winningWordArray[1] = String(nextWord[idx])
    
    idx = nextWord.index(after: idx)
    winningWordArray[2] = String(nextWord[idx])
    
    idx = nextWord.index(after: idx)
    winningWordArray[3] = String(nextWord[idx])
    
    idx = nextWord.index(after: idx)
    winningWordArray[4] = String(nextWord[idx])
    
    return winningWordArray
}
