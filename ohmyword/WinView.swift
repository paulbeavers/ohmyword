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
        Text("You won! You guessed in \(tries)!")
    }
}

struct WinView_Previews: PreviewProvider {
    static var previews: some View {
        WinView(tries:"1")
    }
}
