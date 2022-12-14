//
//  Game.swift
//  Davolo
//
//  Created by Xeo Gillis on 05/10/2022.
//

import Foundation
import MessageUI

struct Game {
    
    // ATTRIBUTES
    
    private(set) var players: Array<Player>
    private(set) var positions: Array<Position>
<<<<<<< HEAD
    private(set) var playersPOST = Array(repeating: "", count: 7)
    private let emojies = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵"]
    
<<<<<<< HEAD
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
=======
    // INITIALIZATION - UPDATE PLAYERS AND POSITIONS ON CHANGE
    
    init() {
        players = Array<Player>()
        positions = Array<Position>()
=======
    private(set) var playersPOST: Array<String>
    private let emojies = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵"]
    
    // INITIALIZATION - UPDATE PLAYERS AND POSITIONS ON CHANGE
    
    init() {
        players = Array<Player>()
        positions = Array<Position>()
        playersPOST = Array<String>()
>>>>>>> daf6da9 (animations)
    }
    mutating func updatePlayers(_ allPlayers: Array<VolleyballGame.Player>) {
        players = Array<Player>()
        allPlayers.forEach { player in
            let positions = player.position.split(separator: " ")
            players.append(Player(position: positions.map { Int($0)! }, content: player.name, id: player.number))
<<<<<<< HEAD
>>>>>>> 5d159dc (almost done)
=======
>>>>>>> daf6da9 (animations)
        }
    }
    mutating func updatePositions(_ allPositions: Array<VolleyballGame.Position>) {
        positions = Array<Position>()
        allPositions.forEach { positions.append(Position(id: $0.id, content: String($0.position), image: emojies[Int.random(in: 0..<emojies.count)])) }
<<<<<<< HEAD
=======
        playersPOST = Array(repeating: "", count: allPositions.count)
>>>>>>> daf6da9 (animations)
    }
    
    // STARTSCREEN
    
    mutating func selectAllPlayers() {
        players.indices.forEach { players[$0].isSelected = true }
    }
    mutating func addPlayer(with number : Int) {
        players.indices.forEach { if players[$0].id == number { players[$0].isSelected.toggle() } }
    }
    
    // CHOOSE POSITION AND PLAYER
<<<<<<< HEAD
    
    mutating func addPlayer(with number : Int) {
        players.indices.forEach { if players[$0].id == number { players[$0].isSelected = true } }
    }
=======
>>>>>>> daf6da9 (animations)
    
    mutating func choosePosition(_ namedPosition : Int) {
        for index in players.indices {
            let suitable = players[index].position.contains(namedPosition) && !players[index].isAlreadyChosen
            players[index].isFaceUp = suitable
            
        }
    }
    mutating func choosePlayer(_ namedPlayer : Int, at namedPosition : Int) {
        playersPOST[namedPosition-1] = getPlayerById(namedPlayer)
        for index in positions.indices {
            if positions[index].content == String(namedPosition) {
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
    func getPlayerById(_ id: Int) -> String {
        var answer = ""
        players.indices.forEach { if players[$0].id == id { answer = players[$0].content }}
        return answer
    }
    
    // BUTTONS
    
    mutating func cancelSetUp() {
        for index in positions.indices {
            positions[index].isFilledIn = false
        }
        for index in players.indices {
            players[index].isFaceUp = false
            players[index].isAlreadyChosen = false
        }
    }
<<<<<<< HEAD
    mutating func saveSetUp() {
=======
    mutating func saveSetUp(mailto mail: String) {
>>>>>>> daf6da9 (animations)
        var positionsPOST = ""
        positions.indices.forEach {
            positionsPOST += String(positions[$0].id) + " "
        }
<<<<<<< HEAD
        save(positionsPOST, playersPOST.joined(separator: " "))
    }
    func postAPI(_ pos: String, _ play: String) async {
=======
        save(positionsPOST, playersPOST.joined(separator: " "), mailto: mail)
    }
    func postAPI(_ pos: String, _ play: String, _ mail: String) async {
>>>>>>> daf6da9 (animations)
        let url = URL(string: "http://localhost:9000/api/match")
        guard let requestUrl = url else { fatalError() }

        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"

<<<<<<< HEAD
        let postString = "position=" + pos + "&player=" + play + "&mail=xeo.gillis@gmail.com";
        print(postString)
=======
        let postString = "position=" + pos + "&player=" + play + "&mail=" + mail;
>>>>>>> daf6da9 (animations)

        request.httpBody = postString.data(using: String.Encoding.utf8);

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
                return
            }
        }
        task.resume()
    }
<<<<<<< HEAD
    func save(_ pos: String, _ play: String) {
        Task {
            await postAPI(pos, play)
=======
    func save(_ pos: String, _ play: String, mailto mail: String) {
        Task {
            await postAPI(pos, play, mail)
>>>>>>> daf6da9 (animations)
        }
    }

    
    // STRUCTS
    
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
        var image: String
    }
}

