//
//  ContentView.swift
//  Davolo
//
//  Created by Xeo Gillis on 05/10/2022.
//

import SwiftUI
import Router

struct ContentView: View {
    @ObservedObject var viewModel: VolleyballGame
    
    var body: some View {
        Router("/") {
            Route("/") {
                Text("Selecteer spelers").font(.largeTitle).foregroundColor(.yellow)
                SelectPlayersView(viewModel: viewModel)
                Spacer()
                ButtonSelectView()
            }
            Route("/davolo") {
                Text("Opstelling").font(.largeTitle).foregroundColor(.yellow)
                PositionListView(viewModel: viewModel)
                Spacer()
                ButtonsView(viewModel: viewModel)
            }
            Route("/davolo/{position}") {
                PlayerListView(viewModel: viewModel)
            }
        }
    }
}

struct SelectPlayersView: View {
    @ObservedObject var viewModel: VolleyballGame
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.players) { player in
                    PlayerSelectView(player: player, viewModel: viewModel)
                }
            }
        }
    }
}

struct PlayerListView: View {
    @ObservedObject var viewModel: VolleyballGame
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.players) { player in
                    PlayerView(player: player, viewModel: viewModel)
                }
            }
        }.padding(.horizontal).foregroundColor(.teal)
    }
}

struct PositionListView: View {
    @ObservedObject var viewModel: VolleyballGame
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        VStack {
            NavigationView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.positions) { position in
                        PositionView(position: position, viewModel: viewModel)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }.navigationViewStyle(.stack)
            Spacer()
        }.padding(.horizontal)
    }
}

struct PlayerSelectView: View {
    let player: Game.Player
    @ObservedObject var viewModel: VolleyballGame
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius:30)
            shape.fill()
            Text(player.content).font(.body).foregroundColor(.blue)
        }
    }
}

struct PlayerView: View {
    let player: Game.Player
    @Environment(\.navigator) private var navigator: Binding<Navigator>
    @ObservedObject var viewModel: VolleyballGame
    
    var body: some View {
        if player.isFaceUp {
            Button(action: {
                viewModel.choosePlayer(player.id)
                navigator.pop {
                    navigator.wrappedValue.path = "/davolo"
                }
            }) {
                ZStack {
                    let shape = RoundedRectangle(cornerRadius:30)
                    shape.fill()
                    Text(player.content).font(.body).foregroundColor(.blue)
                }
            }
        } else {
            ZStack {
                let shape = RoundedRectangle(cornerRadius:30)
                shape.fill()
            }
        }
    }
}

struct PositionView: View {
    let position: Game.Position
    @ObservedObject var viewModel: VolleyballGame
    @Environment(\.navigator) private var navigator: Binding<Navigator>
    
    var body: some View {
        Button(action: {
            viewModel.choosePosition(position.id)
            navigator.push {
                navigator.wrappedValue.path = "/davolo/\(position)"
            }
        }) {
            if (position.isFilledIn) {
                ZStack {
                    let shape = Rectangle()
                    shape.fill()
                    Text(position.content).foregroundColor(.blue)
                }.foregroundColor(.green)
            }
            else {
                ZStack {
                    let shape = Rectangle()
                    shape.fill()
                    Text(position.content).foregroundColor(.blue)
                }.foregroundColor(.teal)
            }
        }
    }
}

struct ButtonsView: View {
    @ObservedObject var viewModel: VolleyballGame
    let shape = RoundedRectangle(cornerRadius: 30)
    
    var body: some View {
        HStack {
            ZStack {
                shape.fill()
                shape.strokeBorder(lineWidth: 3).foregroundColor(.red)
                Button("❌"){
                    viewModel.cancelSetUp()
                }
            }.padding(.horizontal)
            Spacer()
            ZStack {
                shape.fill()
                shape.strokeBorder(lineWidth: 3).foregroundColor(.green)
                Button("✔️"){
                    viewModel.saveSetUp()
                }
            }.padding(.horizontal)
        }.foregroundColor(.white).frame(height: 40).padding(.vertical)
    }
}

struct ButtonSelectView: View {
    @Environment(\.navigator) private var navigator: Binding<Navigator>
    
    var body: some View {
        Button(action: {
            navigator.push {
                navigator.wrappedValue.path = "/davolo"
            }
        }) {
            Text("Verder")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = VolleyballGame()
        ContentView(viewModel: game).preferredColorScheme(.dark)
        ContentView(viewModel: game).preferredColorScheme(.light)
    }
}
