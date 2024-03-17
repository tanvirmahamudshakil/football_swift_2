// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let teamPlayer = try? JSONDecoder().decode(TeamPlayer.self, from: jsonData)

import Foundation

// MARK: - TeamPlayerElement
struct TeamPlayerElement: Hashable, Codable {
    let player: Player?
    let statistics: [Statisticq]?
}

// MARK: - Player
struct Player:Hashable, Codable {
    let id: Int?
    let name, firstname, lastname: String?
    let age: Int?
    let birth: Birth?
    let nationality: String?
    let height, weight: String?
    let injured: Bool?
    let photo: String?
}

// MARK: - Birth
struct Birth:Hashable, Codable {
    let date: String?
    let place: String?
    let country: String?
}

// MARK: - Statistic
struct Statisticq:Hashable, Codable {
    let team: Team?
    let league: Leagueq?
    let games: Gamesq?
    let substitutes: Substitutesq?
    let shots: Shotsq?
    let goals: Goalsq?
    let passes: Passesq?
    let tackles: Tacklesq?
    let duels: Duelsq?
    let dribbles: Dribblesq?
    let fouls: Foulsq?
    let cards: Cardsq?
    let penalty: Penaltyq?
}

// MARK: - Cards
struct Cardsq:Hashable, Codable {
    let yellow, yellowred, red: Int?
}

// MARK: - Dribbles
struct Dribblesq:Hashable, Codable {
    let attempts, success: Int?

}

// MARK: - Duels
struct Duelsq:Hashable, Codable {
    let total, won: Int?
}

// MARK: - Fouls
struct Foulsq:Hashable, Codable {
    let drawn, committed: Int?
}

// MARK: - Games
struct Gamesq:Hashable, Codable {
    let appearences, lineups, minutes: Int?
    let position: String?
    let rating: String?
    let captain: Bool?
}



// MARK: - Goals
struct Goalsq:Hashable, Codable {
    let total: Int?
    let conceded, assists, saves: Int?
}

// MARK: - League
struct Leagueq:Hashable, Codable {
    let id: Int?
    let name: String?
    let country: String?
    let logo: String?
    let flag: String?
    let season: Seasonq?
}




enum Seasonq:Hashable, Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Season.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Season"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Passes
struct Passesq:Hashable, Codable {
    let total, key, accuracy: Int?
}

// MARK: - Penalty
struct Penaltyq:Hashable, Codable {
    let won: Int?
    let scored, missed, saved: Int?
}

// MARK: - Shots
struct Shotsq:Hashable, Codable {
    let total, on: Int?
}

// MARK: - Substitutes
struct Substitutesq:Hashable, Codable {
    let substitutesIn, out, bench: Int?

    enum CodingKeys: String, CodingKey {
        case substitutesIn = "in"
        case out, bench
    }
}

// MARK: - Tackles
struct Tacklesq:Hashable, Codable {
    let total, blocks, interceptions: Int?
}

// MARK: - Team
struct Team:Hashable, Codable {
    let id: Int?
    let name: String?
    let logo: String?
}



typealias TeamPlayer = [TeamPlayerElement]

// MARK: - Encode/decode helpers
