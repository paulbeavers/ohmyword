//
//  ContentView.swift
//  ohmyword
//
//  Created by paul beavers on 4/8/22.
//

import SwiftUI


struct ContentView: View {
    
    @State private var word = ["A", "D", "I", "E", "U"]
    
    @State private var try1 = ["", "", "", "", ""]
    @State private var try2 = ["", "", "", "", ""]
    @State private var try3 = ["", "", "", "", ""]
    @State private var try4 = ["", "", "", "", ""]
    @State private var try5 = ["", "", "", "", ""]
    @State private var try6 = ["", "", "", "", ""]
    @State private var bgColor:Color = Color.white
    
    @State private var color2D:[[Color]] = [ [Color.gray, Color.gray, Color.gray,Color.gray, Color.gray],
                [Color.gray, Color.gray, Color.gray,Color.gray, Color.gray],
                [Color.gray, Color.gray, Color.gray,Color.gray, Color.gray],
                [Color.gray, Color.gray, Color.gray,Color.gray, Color.gray],
                [Color.gray, Color.gray, Color.gray,Color.gray, Color.gray],
                [Color.gray, Color.gray, Color.gray,Color.gray, Color.gray]]
    
    @State private var letters2D:[[String]] = [ ["1", " ", " "," ", " "],
                                                ["2", " ", " "," ", " "],
                                                ["3", " ", " "," ", " "],
                                                ["4", " ", " "," ", " "],
                                                ["5", " ", " "," ", " "],
                                                ["6", " ", " "," ", " "]]
    
    @State private var currentRow = 0
    @State private var currentColumn = 0
    
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
    
    
    private var colors: [Color] = [.yellow, .purple, .green, .white, .gray]
    
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
    
    func addLetter(letterToAdd: String) {
        letters2D[currentRow][currentColumn] = letterToAdd
        currentColumn = currentColumn + 1
        
        if (currentColumn > 4) {
            currentColumn = 0
            currentRow = currentRow + 1
            
            if (currentRow > 5) {
                currentRow = 0
            }
        }
    }
    
    
    var body: some View {
        
            LazyVGrid(columns: gridItemLayout, spacing: 5) {
                ForEach(Array(letters2D[0].enumerated()), id: \.offset) { index, letter in
                        Text(letter)
                            .font(.system(size: 18))
                            .frame(width: 60, height: 60)
                            .background(color2D[0][index])
                            .cornerRadius(10)
                            .multilineTextAlignment(.center)
                }
            }
        
            LazyVGrid(columns: gridItemLayout, spacing: 5) {
                ForEach(Array(letters2D[1].enumerated()), id: \.offset) { index, letter in
                    Text(letter)
                        .font(.system(size: 18))
                        .frame(width: 60, height: 60)
                        .background(color2D[1][index])
                        .cornerRadius(10)
                        .multilineTextAlignment(.center)
                }
            }
        
            LazyVGrid(columns: gridItemLayout, spacing: 5) {
                ForEach(Array(letters2D[2].enumerated()), id: \.offset) { index, letter in
                    Text(letter)
                        .font(.system(size: 18))
                        .frame(width: 60, height: 60)
                        .background(color2D[2][index])
                        .cornerRadius(10)
                        .multilineTextAlignment(.center)
                }
            }
        
        LazyVGrid(columns: gridItemLayout, spacing: 5) {
            ForEach(Array(letters2D[3].enumerated()), id: \.offset) { index, letter in
                Text(letter)
                    .font(.system(size: 18))
                    .frame(width: 60, height: 60)
                    .background(color2D[3][index])
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
            }
        }
        
        LazyVGrid(columns: gridItemLayout, spacing: 5) {
            ForEach(Array(letters2D[4].enumerated()), id: \.offset) { index, letter in
                Text(letter)
                    .font(.system(size: 18))
                    .frame(width: 60, height: 60)
                    .background(color2D[4][index])
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
            }
        }
        
        LazyVGrid(columns: gridItemLayout, spacing: 5) {
            ForEach(Array(letters2D[5].enumerated()), id: \.offset) { index, letter in
                Text(letter)
                    .font(.system(size: 18))
                    .frame(width: 60, height: 60)
                    .background(color2D[5][index])
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
            }
        }
        
       
        
        Group {
        LazyVGrid(columns: letters10ItemLayout, spacing: 10) {
            Button("Q") {
              addLetter(letterToAdd: "Q")
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            .frame(width: 40 , height: 40, alignment: .center)
            
            Button("W") {
                addLetter(letterToAdd: "W")
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("E") {
                addLetter(letterToAdd: "E")
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("R") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("T") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("Y") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("U") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("I") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("O") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("P") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
        }
        
        LazyVGrid(columns: letters9ItemLayout, spacing: 10) {
            Button("A") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            .frame(width: 40 , height: 40, alignment: .center)
            
            Button("S") {
                
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("D") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("F") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("G") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("H") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("J") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("K") {
              // button tapped
              
            }
            .frame(width: 40 , height: 40, alignment: .center)
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("L") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
        }
        
        LazyVGrid(columns: letters7ItemLayout, spacing: 10) {
            Button("Z") {
              letters2D[0][0] = "Z"
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            .frame(width: 40 , height: 40, alignment: .center)
            
            Button("X") {
                
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("C") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("V") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("B") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("N") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
            Button("M") {
              // button tapped
              
            }
            .buttonStyle(RoundedRectangleButtonStyle())
            
        }
        
    }
        
        Button("Button title") {
            print("Button tapped!")
            color2D[2][3] = Color.blue
            color2D[3][3] = Color.yellow
            letters2D[2][3] = "X"
            letters2D[3][3] = "Y"
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
