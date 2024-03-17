// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let leagueTopScore = try? JSONDecoder().decode(LeagueTopScore.self, from: jsonData)

import Foundation

// MARK: - LeagueTopScoreElement
struct LeagueTopScoreElement:Hashable, Codable {
    let player: Playerr?
    let statistics: [Statistic]?
}

// MARK: - Player
struct Playerr:Hashable, Codable {
    let id: Int?
    let name, firstname, lastname: String?
    let age: Int?
    let birth: Birthr?
    let nationality, height, weight: String?
    let injured: Bool?
    let photo: String?
}

// MARK: - Birth
struct Birthr:Hashable, Codable {
    let date, place, country: String?
}

// MARK: - Statistic
struct Statistic: Hashable,Codable {
    let team: Teamr?
    let tackles: Tackles?
    let duels: Duels?
    let dribbles: Dribbles?
    let fouls: Fouls?
    let penalty: Penalty?
}



// MARK: - Team
struct Teamr:Hashable, Codable {
    let id: Int?
    let name: String?
    let logo: String?
}

typealias LeagueTopScore = [LeagueTopScoreElement]

// MARK: - Encode/decode helpers

