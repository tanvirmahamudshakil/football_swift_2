// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let matchDetails = try? JSONDecoder().decode(MatchDetails.self, from: jsonData)

import Foundation

// MARK: - MatchDetail
struct MatchDetail: Hashable, Codable {
    let fixture: Fixture?
    let league: League1?
    let teams: Teams1?
    let goals: MatchDetailGoals?
    let events: [Event]?
    let lineups: [Lineup]?
    let statistics: [MatchDetailStatistic]?
    let players: [MatchDetailPlayer]?
}

struct League1:Hashable, Codable {
    let id: Int?
    let name, country: String?
    let logo: String?
    let flag: String?
    let season: Int?
    let round: String?
}

// MARK: - Event
struct Event:Hashable, Codable {
    let time: Time?
    let team: Away?
    let player, assist: Assist?
    let type: String?
    let detail: String?
    let comments: String?
}

// MARK: - Assist
struct Assist:Hashable, Codable {
    let id: Int?
    let name: String?
}

// MARK: - Away
struct Away:Hashable, Codable {
    let id: Int?
    let name: String?
    let logo: String?
    let colors: Colors?
    let update: String?
    let winner: Bool?
}

// MARK: - Colors
struct Colors:Hashable, Codable {
    let player, goalkeeper: Goalkeeper?
}

// MARK: - Goalkeeper
struct Goalkeeper:Hashable, Codable {
    let primary, number, border: String?
}



// MARK: - Time
struct Time:Hashable, Codable {
    let elapsed: Int?
    let extra: Int?
}




// MARK: - MatchDetailGoals
struct MatchDetailGoals:Hashable, Codable {
    let home, away: Int?
}

// MARK: - Lineup
struct Lineup:Hashable, Codable {
    let team: Away?
    let coach: Coach?
    let formation: String?
    let startXI, substitutes: [StartXi]?
}

// MARK: - Coach
struct Coach:Hashable, Codable {
    let id: Int?
    let name: String?
    let photo: String?
}

// MARK: - StartXi
struct StartXi:Hashable, Codable {
    let player: StartXIPlayer?
}

// MARK: - StartXIPlayer
struct StartXIPlayer:Hashable, Codable {
    let id: Int?
    let name: String?
    let number: Int?
    let pos: Pos?
    let grid: String?
}

enum Pos: String, Codable {
    case d = "D"
    case f = "F"
    case g = "G"
    case m = "M"
}

// MARK: - MatchDetailPlayer
struct MatchDetailPlayer:Hashable, Codable {
    let team: Away?
    let players: [PlayerPlayer]?
}

// MARK: - PlayerPlayer
struct PlayerPlayer:Hashable, Codable {
    let player: Coach?
    let statistics: [PlayerStatistic]?
}

// MARK: - PlayerStatistic
struct PlayerStatistic:Hashable, Codable {
    let games: Games?
    let offsides: Int?
    let shots: Shots?
    let goals: StatisticGoals?
    let passes: Passes?
    let tackles: Tackles?
    let duels: Duels?
    let dribbles: Dribbles?
    let fouls: Fouls?
    let cards: Cards?
    let penalty: Penalty?
}

// MARK: - Cards
struct Cards:Hashable, Codable {
    let yellow, red: Int?
}

// MARK: - Dribbles
struct Dribbles:Hashable, Codable {
    let attempts, success, past: Int?
}

// MARK: - Duels
struct Duels:Hashable, Codable {
    let total, won: Int?
}

// MARK: - Fouls
struct Fouls:Hashable, Codable {
    let drawn, committed: Int?
}

// MARK: - Games
struct Games:Hashable, Codable {
    let minutes: Int?
    let number: Int?
    let position: Pos?
    let rating: String?
    let captain, substitute: Bool?
}

// MARK: - StatisticGoals
struct StatisticGoals:Hashable, Codable {
    let total: Int?
    let conceded: Int?
    let assists, saves: Int?
}

// MARK: - Passes
struct Passes:Hashable, Codable {
    let total, key: Int?
    let accuracy: String?
}

// MARK: - Penalty
struct Penalty:Hashable, Codable {
    let won, commited: Int?
    let scored, missed: Int?
    let saved: Int?
}

// MARK: - Shots
struct Shots:Hashable, Codable {
    let total, on: Int?
}

// MARK: - Tackles
struct Tackles:Hashable, Codable {
    let total, blocks, interceptions: Int?
}

// MARK: - MatchDetailStatistic
struct MatchDetailStatistic:Hashable, Codable {
    let team: Away?
    let statistics: [StatisticStatistic]?
}

// MARK: - StatisticStatistic
struct StatisticStatistic:Hashable, Codable {
    let type: String?
    let value: Value?
}

enum Value:Hashable, Codable {
    case integer(Int)
    case string(String)
    case null

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
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(Value.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Value"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - Teams1
struct Teams1:Hashable,Codable {
    let home, away: Away?
}

typealias MatchDetails = [MatchDetail]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
