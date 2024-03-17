// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let teamStatistic = try? JSONDecoder().decode(TeamStatistic.self, from: jsonData)

import Foundation

// MARK: - TeamStatistic
struct TeamStatistic: Codable {
    let league: League?
    let team: Team?
    let form: String?
    let fixtures: Fixturesq?
    let goals: TeamStatisticGoals?
    let biggest: Biggest?
    let cleanSheet, failedToScore: CleanSheet?
    let lineups: [Lineupq]?

    enum CodingKeys: String, CodingKey {
        case league, team, form, fixtures, goals, biggest
        case cleanSheet = "clean_sheet"
        case failedToScore = "failed_to_score"
        case  lineups
    }
}

// MARK: - Biggest
struct Biggest: Codable {
    let streak: Streak?
    let wins, loses: Loses?
    let goals: BiggestGoals?
}

// MARK: - BiggestGoals
struct BiggestGoals: Codable {
    let goalsFor, against: PurpleAgainst?

    enum CodingKeys: String, CodingKey {
        case goalsFor = "for"
        case against
    }
}

// MARK: - PurpleAgainst
struct PurpleAgainst: Codable {
    let home, away: Int?
}

// MARK: - Loses
struct Loses: Codable {
    let home, away: String?
}

// MARK: - Streak
struct Streak: Codable {
    let wins, draws, loses: Int?
}



// MARK: - Missed
struct Missed: Codable {
    let total: Int?
    let percentage: String?
}

// MARK: - CleanSheet
struct CleanSheet: Codable {
    let home, away, total: Int?
}

// MARK: - Fixtures
struct Fixturesq: Codable {
    let played, wins, draws, loses: CleanSheet?
}

// MARK: - TeamStatisticGoals
struct TeamStatisticGoals: Codable {
    let goalsFor, against: FluffyAgainst?

    enum CodingKeys: String, CodingKey {
        case goalsFor = "for"
        case against
    }
}

// MARK: - FluffyAgainst
struct FluffyAgainst: Codable {
    let total: CleanSheet?
    let average: Average?
    let minute: [String: Missed]?
}

// MARK: - Average
struct Average: Codable {
    let home, away, total: String?
}



// MARK: - Lineup
struct Lineupq: Codable {
    let formation: String?
    let played: Int?
}



