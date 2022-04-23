//
//  ContentView.swift
//  ohmyword
//
//  Created by paul beavers on 4/8/22.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common)
    @State private var timerSubscription: Cancellable?

    @State private var showAlert = false
    
    @State private var userWon = false
    @State private var wonInTries:Int = 0
    
    @State private var winningWord = getNextWordArray() // ["A", "D", "I", "E", "U"]
    @State private var wrongArray:[String] = ["", "", "", "", ""]
    
    @State private var bgColor:Color = Color.white
    
    @State private var row1Letters = ["Q", "W", "E", "R","T", "Y", "U", "I", "O", "P"]
    @State private var row2Letters = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
    @State private var row3Letters = ["Z", "X", "C", "V", "B", "N", "M"]
    
    @State private var color2D:[[Color]] = [ [Color.gray, Color.gray, Color.gray,Color.gray, Color.gray],
                [Color.gray, Color.gray, Color.gray,Color.gray, Color.gray],
                [Color.gray, Color.gray, Color.gray,Color.gray, Color.gray],
                [Color.gray, Color.gray, Color.gray,Color.gray, Color.gray],
                [Color.gray, Color.gray, Color.gray,Color.gray, Color.gray],
                [Color.gray, Color.gray, Color.gray,Color.gray, Color.gray]]
    
    @State private var letters2D:[[String]] = [ [" ", " ", " "," ", " "],
                                                [" ", " ", " "," ", " "],
                                                [" ", " ", " "," ", " "],
                                                [" ", " ", " "," ", " "],
                                                [" ", " ", " "," ", " "],
                                                [" ", " ", " "," ", " "]]
    
    @State private var currentRow = 0
    @State private var currentColumn = 0
    @State private var checkGuessWord:Bool = true
    
    private var gridItemLayout = [GridItem(.fixed(60), spacing: 5), GridItem(.fixed(60), spacing: 5),
                                   GridItem(.fixed(60), spacing: 5), GridItem(.fixed(60), spacing: 5),
                                  GridItem(.fixed(60), spacing: 5)]
    
    private var letters10ItemLayout = [GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1)]
    
    private var letters9ItemLayout = [GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1)]
    
    private var letters7ItemLayout = [GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1),
                                      GridItem(.fixed(40), spacing: 1)]
    
    private var controlButtonItemLayout = [GridItem( spacing: 1),
                                           GridItem( spacing: 1)]
    
    
    //-------------------------------------------------------
    // init
    //-------------------------------------------------------
    init() {
        self.resetGame()
    }
    
    //-------------------------------------------------------
    // letter button style
    //-------------------------------------------------------
    struct RoundedRectangleButtonStyle: ButtonStyle {
      func makeBody(configuration: Configuration) -> some View {
        Button(action: {}, label: {
          HStack {
            configuration.label.foregroundColor(.black)
          }
        })
        // 👇🏻 makes all taps go to the original button
        .frame(width: 20 , height: 20, alignment: .center)

        .allowsHitTesting(false)
        .padding(10)
        .background(Color.gray.cornerRadius(8))
        .font(.system(size: 14, design: .default))
        
     //   .scaleEffect(configuration.isPressed ? 0.95 : 1)
      }
    }
    
    //-------------------------------------------------------
    // control button style
    //-------------------------------------------------------
    struct ControlButtonStyle: ButtonStyle {
      func makeBody(configuration: Configuration) -> some View {
        Button(action: {}, label: {
          HStack {
            configuration.label.foregroundColor(.black)
          }
        })
        // 👇🏻 makes all taps go to the original button
        .frame(width: 80 , height: 20, alignment: .center)

        .allowsHitTesting(false)
        .padding(10)
        .background(Color.gray.cornerRadius(8))
        .font(.system(size: 14, design: .default))
        
     //   .scaleEffect(configuration.isPressed ? 0.95 : 1)
      }
    }
    
    //-------------------------------------------------------
    // add a letter when the user types it
    //-------------------------------------------------------
    func addLetter(letterToAdd: String) {
        letters2D[currentRow][currentColumn] = letterToAdd
        
        if (currentColumn == 4)
        {
            
        }
        else
        {
            currentColumn = currentColumn + 1
        
            if (currentColumn > 4) {
                currentColumn = 0
                currentRow = currentRow + 1
            
                if (currentRow > 5) {
                    currentRow = 0
                }
            }
        }
    }
    
    //-------------------------------------------------------
    // check word and set colors
    //-------------------------------------------------------
    func checkWordAndSetColors() -> Int {
        var n:Int = 0
        var i:Int = 0
        var greenCount:Int = 0
        
        while(i<5)
        {
            if (letters2D[currentRow][i] == winningWord[i])
            {
                color2D[currentRow][i] = Color.green
                greenCount = greenCount + 1
            }
            i = i + 1
        }
        i = 0
        while(i<5)
        {
            n = 0
            while(n<5)
            {
                    if (letters2D[currentRow][i] == winningWord[n])
                    {
                        if (i != n) {
                            color2D[currentRow][i] = Color.yellow
                        }
                    }
                n = n + 1
            }
            i = i + 1
        }
        
        i = 0
        while(i<5)
        {
            if (color2D[currentRow][i] == Color.gray)
            {
                color2D[currentRow][i] = Color.blue
            }
            i = i + 1
        }
        
        return greenCount
    }
    
    //-------------------------------------------------------
    // SyncEnterHandler
    //-------------------------------------------------------
    func SyncEnterHandler() {
        var greenCount:Int = 0
        
        if (currentColumn == 4 && letters2D[currentRow][currentColumn] != " ")
        {
            greenCount = checkWordAndSetColors()
            currentRow = currentRow + 1
            currentColumn = 0
        }
    
        if (greenCount == 5)
        {
            userWon = true
            timerSubscription = timer.connect()
            wonInTries = currentRow
        }
        else {
            if (currentRow == 6) {
                userWon = false
                wrongArray = winningWord
                timerSubscription = timer.connect()
            }
        }
        
    }
    
    //-------------------------------------------------------
    // ASyncEnterHandler
    //-------------------------------------------------------
    func AsyncEnterHandler() {
        var greenCount:Int = 0
        var foundWord:Bool = false
        
        let checkString:String = letters2D[currentRow][0] + letters2D[currentRow][1] + letters2D[currentRow][2] +
        letters2D[currentRow][3] + letters2D[currentRow][4]
        
        guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/" + checkString) else{
            return
        }

        let group = DispatchGroup()
        group.enter()
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in defer { group.leave() }
            
            print(data ?? "default value")
            print(response ?? "default respose")
            
            foundWord = false
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                
                if (httpResponse.statusCode < 300) {
                    foundWord = true
                }
            }
        } // task

        task.resume()
        
        group.notify(queue: .main) {
            //print(myError)
            
            
            if (foundWord) {
                
                greenCount = checkWordAndSetColors()
                currentRow = currentRow + 1
                currentColumn = 0
            
                if (greenCount == 5)
                {
                    userWon = true
                    timerSubscription = timer.connect()
                    wonInTries = currentRow
                }
                else {
                    if (currentRow == 6) {
                        userWon = false
                        wrongArray = winningWord
                        timerSubscription = timer.connect()
                    }
                }
            }
        }
        
    }
    
    //-------------------------------------------------------
    // Reset Game
    //-------------------------------------------------------
    func resetGame() {
        var n:Int = 0
        var i:Int = 0
        currentRow = 0
        currentColumn = 0
        
        winningWord = getNextWordArray()
         
        while(i<6)
        {
            n = 0
            while(n<5)
            {
                letters2D[i][n] = " "
                color2D[i][n] = Color.gray
                n = n + 1
            }
            i = i + 1
        }
    }
    
    //-------------------------------------------------------
    // Build the main view
    //-------------------------------------------------------
    var body: some View {

        VStack(spacing: 30) {
            VStack(spacing: 10) {
                
                Text("Oh My Word!")
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                
                Text("  ")
                    .font(.system(size: 28))
                
                LazyVGrid(columns: gridItemLayout, spacing: 5) {
                    ForEach(Array(letters2D[0].enumerated()), id: \.offset) { index, letter in
                            Text(letter)
                                .font(.system(size: 28))
                                .frame(width: 60, height: 60)
                                .background(color2D[0][index])
                                .cornerRadius(10)
                                .multilineTextAlignment(.center)
                    }
                }
        
                LazyVGrid(columns: gridItemLayout, spacing: 5) {
                    ForEach(Array(letters2D[1].enumerated()), id: \.offset) { index, letter in
                        Text(letter)
                            .font(.system(size: 28))
                            .frame(width: 60, height: 60)
                            .background(color2D[1][index])
                            .cornerRadius(10)
                            .multilineTextAlignment(.center)
                    }
                }
        
                LazyVGrid(columns: gridItemLayout, spacing: 5) {
                    ForEach(Array(letters2D[2].enumerated()), id: \.offset) { index, letter in
                        Text(letter)
                            .font(.system(size: 28))
                            .frame(width: 60, height: 60)
                            .background(color2D[2][index])
                            .cornerRadius(10)
                            .multilineTextAlignment(.center)
                    }
                }
        
                LazyVGrid(columns: gridItemLayout, spacing: 5) {
                    ForEach(Array(letters2D[3].enumerated()), id: \.offset) { index, letter in
                        Text(letter)
                            .font(.system(size: 28))
                            .frame(width: 60, height: 60)
                            .background(color2D[3][index])
                            .cornerRadius(10)
                            .multilineTextAlignment(.center)
                    }
                }
                
                LazyVGrid(columns: gridItemLayout, spacing: 5) {
                    ForEach(Array(letters2D[4].enumerated()), id: \.offset) { index, letter in
                        Text(letter)
                            .font(.system(size: 28))
                            .frame(width: 60, height: 60)
                            .background(color2D[4][index])
                            .cornerRadius(10)
                            .multilineTextAlignment(.center)
                    }
                }
                
                LazyVGrid(columns: gridItemLayout, spacing: 5) {
                    ForEach(Array(letters2D[5].enumerated()), id: \.offset) { index, letter in
                        Text(letter)
                            .font(.system(size: 28))
                            .frame(width: 60, height: 60)
                            .background(color2D[5][index])
                            .cornerRadius(10)
                            .multilineTextAlignment(.center)
                    }
                }
            }
        
       
            VStack(spacing: 8) {
        
                LazyVGrid(columns: letters10ItemLayout, spacing: 10) {
                    ForEach(Array(row1Letters.enumerated()), id: \.offset) { index, letter in
                        Button(letter)
                        {
                            addLetter(letterToAdd: letter)
                        }
                        .buttonStyle(RoundedRectangleButtonStyle())
                    }
                    
                }
                
                LazyVGrid(columns: letters9ItemLayout, spacing: 10) {
                    ForEach(Array(row2Letters.enumerated()), id: \.offset) { index, letter in
                        Button(letter)
                        {
                            addLetter(letterToAdd: letter)
                        }
                        .buttonStyle(RoundedRectangleButtonStyle())
                    }
                   
                }
                
                LazyVGrid(columns: letters7ItemLayout, spacing: 10) {
                    ForEach(Array(row3Letters.enumerated()), id: \.offset) { index, letter in
                        Button(letter)
                        {
                            addLetter(letterToAdd: letter)
                        }
                        .buttonStyle(RoundedRectangleButtonStyle())
                    }
                   
                }
            }
        
            LazyVGrid(columns: controlButtonItemLayout, spacing: 10) {
                Button("Enter") {
                    if (currentColumn == 4 && letters2D[currentRow][currentColumn] != " ")
                    {
                        if (checkGuessWord)
                        {
                            AsyncEnterHandler()
                        }
                        else
                        {
                            SyncEnterHandler()
                        }
                    }
                }
                .buttonStyle(ControlButtonStyle())
            
                Button("Delete") {
                    if (currentColumn > 0) {
                        if (currentColumn != 4) {
                            currentColumn = currentColumn - 1
                        }
                        else
                        {
                            if (letters2D[currentRow][currentColumn] == " ") {
                                currentColumn = currentColumn - 1
                            }
                        }
                    }
                    letters2D[currentRow][currentColumn] = " "
              
                }
                .buttonStyle(ControlButtonStyle())
            }
        }
        .sheet(isPresented: $showAlert) {
            if (userWon) {
                let tries:String = String(wonInTries)
                WinView(tries:tries)
            }
            else {
                LoseView(winningWord: wrongArray[0] + wrongArray[1] + wrongArray[2] + wrongArray[3] +
                         wrongArray[4])
            }
        }
        .onReceive(timer) { input in
            showAlert = true
            timerSubscription?.cancel()
            timerSubscription = nil
            timer = Timer.publish(every: 1, on: .main, in: .common)
            resetGame()
        }
    }
}
    

    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
