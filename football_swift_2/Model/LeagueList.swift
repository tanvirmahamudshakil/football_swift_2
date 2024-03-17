// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let leagueList = try? JSONDecoder().decode(LeagueList.self, from: jsonData)

import Foundation

// MARK: - LeagueListElement
struct LeagueListElement:Hashable, Codable {
    let league: Leagues
    let country: Country
    let seasons: [Season]
}

// MARK: - Country
struct Country:Hashable, Codable {
    let name: String
    let code: String?
    let flag: String?
}

// MARK: - League
struct Leagues:Hashable, Codable {
    let id: Int
    let name: String
    let type: String
    let logo: String
}



// MARK: - Season
struct Season:Hashable, Codable {
    let year: Int
    let start, end: String
    let current: Bool
    let coverage: Coverage
}

// MARK: - Coverage
struct Coverage:Hashable, Codable {
    let fixtures: Fixtures
    let standings, players, topScorers, topAssists: Bool
    let topCards, injuries, predictions, odds: Bool

    enum CodingKeys: String, CodingKey {
        case fixtures, standings, players
        case topScorers = "top_scorers"
        case topAssists = "top_assists"
        case topCards = "top_cards"
        case injuries, predictions, odds
    }
}

// MARK: - Fixtures
struct Fixtures:Hashable, Codable {
    let events, lineups, statisticsFixtures, statisticsPlayers: Bool

    enum CodingKeys: String, CodingKey {
        case events, lineups
        case statisticsFixtures = "statistics_fixtures"
        case statisticsPlayers = "statistics_players"
    }
}

typealias LeagueList = [LeagueListElement]
