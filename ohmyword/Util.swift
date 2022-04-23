//
//  Util.swift
//  ohmyword
//
//  Created by paul beavers on 4/16/22.
//

import Foundation

var wordArray:[String] = ["HOUSE", "BOAST", "BOATS", "LOUSE", "ROAST",
    "HEIST", "FIEND", "FORAY", "ROYAL", "CLUES", "BLUES", "TOAST", "SCORE", "SCREW", "STEAM", "POUND",
    "FOUND", "ROUND", "THREW", "PRINT", "PRIME", "QUIET", "QUEST", "STAIR", "STARE", "GROWN", "GROAN", "GRIEF", "ULTRA", "LIKES", "CLONE",
    "SOUND", "HOUND", "MOVED"]

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


func callAPI(){
    var data1 = "aaaa"
    guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/hello") else{
        return
    }

    let group = DispatchGroup()

    group.enter()
    let task = URLSession.shared.dataTask(with: url){
        data, response, error in defer { group.leave() }
        
        if let data = data, let string = String(data: data, encoding: .utf8){
            data1 = string
            print(string)
        }
    }

    task.resume()
    
    group.notify(queue: .main) {
            print(data1)
        }
}
