//
//  VolleyballGame.swift
//  Davolo
//
//  Created by Xeo Gillis on 05/10/2022.
//

import Foundation

class VolleyballGame: ObservableObject {
    @Published var allPlayers: Array<Player> {
        didSet {
            updatePlayers(allPlayers)
        }
    }
    static let positions = [4, 3, 2, 5, 6, 1, 7]
    var position = 0
    
    init() {
        allPlayers = Array<Player>()
        fillPlayers()
    }

    static func createGame() -> Game {
        return Game(arrayOfPossiblePositions: positions)
    }

    @Published private var model: Game = createGame()
        
    var players: Array<Game.Player> {
        model.players
    }
    
    var positions: Array<Game.Position> {
        model.positions
    }
    
    func fillPlayers() {
        Task {
            await callAPI()
        }
    }
    
    func callAPI() async {
        guard let url = URL(string: "http://localhost:9000/api/players") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let tasks = try decoder.decode([Player].self, from: data)
                    tasks.forEach { self.allPlayers.append($0) }
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    // MARK - Intent(s)
    func updatePlayers(_ allPlayers: Array<Player>) {
        model.updatePlayers(allPlayers)
    }
    
    func addPlayer(with number : Int) {
        model.addPlayer(with: number)
    }
    
    func choosePosition(_ namedPosition : Int) {
        position = namedPosition
        model.choosePosition(namedPosition)
    }
    
    func choosePlayer(_ namedPlayer: Int) {
        model.choosePlayer(namedPlayer, at: position)
    }
    
    func cancelSetUp() {
        model.cancelSetUp()
    }
    
    func saveSetUp() {
        model.saveSetUp()
    }
    
    struct Player: Codable {
        let name: String
        let number: Int
        let position: String
    }
}
