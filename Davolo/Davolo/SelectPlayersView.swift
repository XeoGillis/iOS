//
//  SelectPlayersView.swift
//  Davolo
//
//  Created by Xeo Gillis on 06/11/2022.
//

import SwiftUI
import Router

struct SelectPlayersView: View {
    @ObservedObject var viewModel: VolleyballGame
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.players) { player in
                    PlayerSelectView(player: player, viewModel: viewModel)
                }
            }
        }.padding(.horizontal).foregroundColor(DavoloColor.Table)
    }
}

struct PlayerSelectView: View {
    let player: Game.Player
    @ObservedObject var viewModel: VolleyballGame
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius:30)
            shape.fill()
            if (player.isSelected) {
                Text(player.content).font(.body).foregroundColor(DavoloColor.Text)
            }
            else {
                Text(player.content).font(.body).foregroundColor(.red)
            }
        }.onTapGesture {
            viewModel.addPlayer(with: player.id)
        }
    }
}

struct ButtonSelectView: View {
    @Environment(\.navigator) private var navigator: Binding<Navigator>
    @ObservedObject var viewModel: VolleyballGame
    let shape = RoundedRectangle(cornerRadius: 30)
    
    var body: some View {
        Spacer()
        HStack {
            Button(action: {
                viewModel.selectAllPlayers()
            }) {
                ZStack {
                    shape.fill()
                    shape.strokeBorder(lineWidth: 3).foregroundColor(.blue)
                    Text("👩‍👩‍👧‍👧").font(.largeTitle)
                }.padding(.horizontal)
            }
            Button(action: {
                navigator.push {
                    navigator.wrappedValue.path = "/davolo"
                }
            }) {
                ZStack {
                    shape.fill()
                    shape.strokeBorder(lineWidth: 3).foregroundColor(.blue)
                    Text("👉").font(.largeTitle)
                }.padding(.horizontal)
            }
        }.foregroundColor(.white).frame(height: 40).padding(.vertical)
    }
}
