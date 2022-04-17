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
        Text("You lost")
        Text("The word was \(winningWord) " )
    }
}

struct LoseView_Previews: PreviewProvider {
    static var previews: some View {
        LoseView(winningWord:"word")
    }
}
