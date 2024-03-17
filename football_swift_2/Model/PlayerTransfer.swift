// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let playerTransfer = try? JSONDecoder().decode(PlayerTransfer.self, from: jsonData)

import Foundation

// MARK: - PlayerTransferElement
struct PlayerTransferElement: Codable {
    let player: Playeru?
    let update: String?
    let transfers: [Transfer]?

    enum CodingKeys: String, CodingKey {
        case player = "player"
        case update = "update"
        case transfers = "transfers"
    }
}

// MARK: - Player
struct Playeru: Codable {
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

// MARK: - Transfer
struct Transfer: Codable {
    let date: String?
    let type: String?
    let teams: Teamsu?

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case type = "type"
        case teams = "teams"
    }
}

// MARK: - Teams
struct Teamsu: Codable {
    let teamsIn: In?
    let out: In?

    enum CodingKeys: String, CodingKey {
        case teamsIn = "in"
        case out = "out"
    }
}

// MARK: - In
struct In: Codable {
    let id: Int?
    let name: String?
    let logo: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case logo = "logo"
    }
}

typealias PlayerTransfer = [PlayerTransferElement]
