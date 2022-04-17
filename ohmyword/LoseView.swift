//
//  LoseView.swift
//  ohmyword
//
//  Created by paul beavers on 4/16/22.
//

import SwiftUI

struct LoseView: View {
    let winningWord: String
    var body: some View {
        Text("You lost!")
            .font(.system(size: 32))
        
        Text("  ")
            .font(.system(size: 32))
        
        Text("The word was \(winningWord). " )
            .font(.system(size: 32))
    }
}

struct LoseView_Previews: PreviewProvider {
    static var previews: some View {
        LoseView(winningWord: "winningWord")
    }
}
