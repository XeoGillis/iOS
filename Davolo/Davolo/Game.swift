//
//  Game.swift
//  Davolo
//
//  Created by Xeo Gillis on 05/10/2022.
//

import Foundation
import MessageUI

struct Game {
    private(set) var players: Array<Player>
    private(set) var positions: Array<Position>
    
    init(arrayOfPossiblePositions: Array<Int>) {
        players = Array<Player>()
        positions = Array<Position>()
        for id in arrayOfPossiblePositions {
            positions.append(Position(id: id, content: String(id)))
        }
    }
    
    mutating func updatePlayers(_ allPlayers: Array<VolleyballGame.Player>) {
        print("update")
        players = Array<Game.Player>()
        allPlayers.forEach { player in
            let positions = player.position.split(separator: " ")
            players.append(Game.Player(position: positions.map { Int($0)! }, content: player.name, id: player.number))
        }
    }
    
    mutating func addPlayer(with number : Int) {
        players.indices.forEach { if players[$0].id == number { players[$0].isSelected = true } }
    }
    
    mutating func choosePosition(_ namedPosition : Int) {
        for index in players.indices {
            let suitable = players[index].position.contains(namedPosition) && !players[index].isAlreadyChosen
            players[index].isFaceUp = suitable
            
        }
    }
    
    mutating func choosePlayer(_ namedPlayer : Int, at namedPosition : Int) {
        for index in positions.indices {
            if positions[index].id == namedPosition {
                if positions[index].isFilledIn == true {
                    editPlayer(index, at: namedPosition)
                }
                positions[index].isFilledIn = true
                positions[index].player = namedPlayer
            }
        }
        for index in players.indices {
            if players[index].id == namedPlayer {
                players[index].isAlreadyChosen = true
            }
            players[index].isFaceUp = false
        }
    }
    
    mutating func editPlayer(_ indexPlayer : Int, at namedPosition : Int) {
        for index in players.indices {
            if players[index].id == positions[indexPlayer].player {
                players[index].isAlreadyChosen = false
            }
        }
    }
    
    mutating func cancelSetUp() {
        for index in positions.indices {
            positions[index].isFilledIn = false
        }
        for index in players.indices {
            players[index].isFaceUp = false
            players[index].isAlreadyChosen = false
        }
    }
    
    mutating func saveSetUp() {
        var mailText = "Opstelling: \n"
        for position in positions {
            mailText += "Positie: " + position.content + " met speler: " + String(position.player) + "\n"
        }
        print(mailText)
    }
    
    struct Player: Identifiable {
        var isSelected: Bool = false
        var isFaceUp: Bool = false
        var isAlreadyChosen: Bool = false
        var position: Array<Int>
        var content: String
        var id: Int
    }
    
    struct Position: Identifiable {
        var id: Int
        var content: String
        var isFilledIn: Bool = false
        var player: Int = 0
    }
}

