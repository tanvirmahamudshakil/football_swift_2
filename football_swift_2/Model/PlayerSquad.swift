// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let playerSquad = try? JSONDecoder().decode(PlayerSquad.self, from: jsonData)

import Foundation

// MARK: - PlayerSquadElement
struct PlayerSquadElement: Codable {
    let team: Teamy?
    let players: [Playery]?

    enum CodingKeys: String, CodingKey {
        case team = "team"
        case players = "players"
    }
}

// MARK: - Player
struct Playery: Codable {
    let id: Int?
    let name: String?
    let age: Int?
    let number: Int?
    let position: String?
    let photo: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case age = "age"
        case number = "number"
        case position = "position"
        case photo = "photo"
    }
}

// MARK: - Team
struct Teamy: Codable {
    let id: Int?
    let name: String?
    let logo: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case logo = "logo"
    }
}

typealias PlayerSquad = [PlayerSquadElement]
