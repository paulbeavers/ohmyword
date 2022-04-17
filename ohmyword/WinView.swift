//
//  WinView.swift
//  ohmyword
//
//  Created by paul beavers on 4/16/22.
//

import SwiftUI

struct WinView: View {
    let tries: String
    var body: some View {
        Text("You won!")
            .font(.system(size: 32))
        
        Text(" ")
            .font(.system(size: 32))
        
        Text("You guessed in \(tries) attempts!")
            .font(.system(size: 32))
        
    }
}

struct WinView_Previews: PreviewProvider {
    static var previews: some View {
        WinView(tries:"1")
    }
}
