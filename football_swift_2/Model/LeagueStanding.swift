// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let leagueStanding = try? JSONDecoder().decode(LeagueStanding.self, from: jsonData)

import Foundation

// MARK: - LeagueStandingElement
struct LeagueStandingElement: Hashable, Codable {
    let league: Leaguew?
}

// MARK: - League
struct Leaguew:Hashable, Codable {
    let id: Int?
    let name: String?
    let country: String?
    let logo: String?
    let flag: String?
    let season: Int?
    let standings: [[Standing]]?
}



// MARK: - Standing
struct Standing:Hashable, Codable {
    let rank: Int?
    let team: Teamw?
    let points, goalsDiff: Int?
    let group: String?
    let form: String?
    let status: String?
    let description: String?
    let all, home, away: All?
    let update: String?
}

// MARK: - All
struct All:Hashable, Codable {
    let played, win, draw, lose: Int?
    let goals: Goalsw?
}

// MARK: - Goals
struct Goalsw:Hashable, Codable {
    let goalsFor, against: Int?

    enum CodingKeys: String, CodingKey {
        case goalsFor = "for"
        case against
    }
}



// MARK: - Team
struct Teamw:Hashable, Codable {
    let id: Int?
    let name: String?
    let logo: String?
}

typealias LeagueStanding = [LeagueStandingElement]
