// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let matchList = try? JSONDecoder().decode(MatchList.self, from: jsonData)

import Foundation

// MARK: - MatchListElement
struct MatchListElement: Hashable, Codable {
    let fixture: Fixture?
    let league: League?
    let teams: Teams?
    let goals: Goals?
    let score: Score?
}

// MARK: - Fixture
struct Fixture: Hashable, Codable {
    let id: Int?
    let referee, timezone: String?
    let date: String?
    let timestamp: Int?
    let periods: Periods?
    let venue: Venue?
    let status: Status?
}

// MARK: - Periods
struct Periods:Hashable, Codable {
    let first, second: Int?
}

// MARK: - Status
struct Status:Hashable, Codable {
    let long, short: String?
    let elapsed: Int?
}

// MARK: - Venue
struct Venue: Hashable, Codable {
    let id: Int?
    let name, city: String?
}

// MARK: - Goals
struct Goals:Hashable, Codable {
    let home, away: Int?
}

// MARK: - League
struct League:Identifiable, Hashable, Codable {
    let id: Int?
    let name, country: String?
    let logo: String?
    let flag: String?
    let season: Int?
    let round: String?
}

// MARK: - Score
struct Score:Hashable, Codable {
    let halftime, fulltime, extratime, penalty: Goals?
}

// MARK: - Teams
struct Teams:Hashable, Codable {
    let home, away: Aways?
}

// MARK: - Aways
struct Aways:Hashable, Codable {
    let id: Int?
    let name: String?
    let logo: String?
    let winner: Bool?
}

typealias MatchList = [MatchListElement]
