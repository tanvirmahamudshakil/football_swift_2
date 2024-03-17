// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let singlePlayerDetails = try? JSONDecoder().decode(SinglePlayerDetails.self, from: jsonData)

import Foundation

// MARK: - SinglePlayerDetail
struct SinglePlayerDetail: Codable {
    let player: Playera?
    let statistics: [Statistica]?

    enum CodingKeys: String, CodingKey {
        case player = "player"
        case statistics = "statistics"
    }
}

// MARK: - Player
struct Playera: Codable {
    let id: Int?
    let name: String?
    let firstname: String?
    let lastname: String?
    let age: Int?
    let birth: Birtha?
    let nationality: String?
    let height: String?
    let weight: String?
    let injured: Bool?
    let photo: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case firstname = "firstname"
        case lastname = "lastname"
        case age = "age"
        case birth = "birth"
        case nationality = "nationality"
        case height = "height"
        case weight = "weight"
        case injured = "injured"
        case photo = "photo"
    }
}

// MARK: - Birth
struct Birtha: Codable {
    let date: String?
    let place: String?
    let country: String?

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case place = "place"
        case country = "country"
    }
}

// MARK: - Statistic
struct Statistica: Codable {
    let team: Teama?
    let league: Leaguea?
    let games: Gamesa?
    let substitutes: Substitutesa?
    let shots: Shotsa?
    let goals: Goalsa?
    let passes: Passesa?
    let tackles: Tacklesa?
    let duels: Duelsa?
    let dribbles: Dribblesa?
    let fouls: Foulsa?
    let cards: Cardsa?
    let penalty: Penaltya?

    enum CodingKeys: String, CodingKey {
        case team = "team"
        case league = "league"
        case games = "games"
        case substitutes = "substitutes"
        case shots = "shots"
        case goals = "goals"
        case passes = "passes"
        case tackles = "tackles"
        case duels = "duels"
        case dribbles = "dribbles"
        case fouls = "fouls"
        case cards = "cards"
        case penalty = "penalty"
    }
}

// MARK: - Cards
struct Cardsa: Codable {
    let yellow: Int?
    let yellowred: Int?
    let red: Int?

    enum CodingKeys: String, CodingKey {
        case yellow = "yellow"
        case yellowred = "yellowred"
        case red = "red"
    }
}

// MARK: - Dribbles
struct Dribblesa: Codable {
    let attempts: Int?
    let success: Int?
    

    enum CodingKeys: String, CodingKey {
        case attempts = "attempts"
        case success = "success"
        
    }
}

// MARK: - Duels
struct Duelsa: Codable {
    let total: Int?
    let won: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case won = "won"
    }
}

// MARK: - Fouls
struct Foulsa: Codable {
    let drawn: Int?
    let committed: Int?

    enum CodingKeys: String, CodingKey {
        case drawn = "drawn"
        case committed = "committed"
    }
}

// MARK: - Games
struct Gamesa: Codable {
    let appearences: Int?
    let lineups: Int?
    let minutes: Int?
    let number: Int?
    let position: String?
    let rating: String?
    let captain: Bool?

    enum CodingKeys: String, CodingKey {
        case appearences = "appearences"
        case lineups = "lineups"
        case minutes = "minutes"
        case number = "number"
        case position = "position"
        case rating = "rating"
        case captain = "captain"
    }
}

// MARK: - Goals
struct Goalsa: Codable {
    let total: Int?
    let conceded: Int?
    let assists: Int?
    let saves: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case conceded = "conceded"
        case assists = "assists"
        case saves = "saves"
    }
}

// MARK: - League
struct Leaguea: Codable {
    let id: Int?
    let name: String?
    let country: String?
    let logo: String?
    let flag: String?
    let season: Seasona?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case country = "country"
        case logo = "logo"
        case flag = "flag"
        case season = "season"
    }
}

enum Seasona: Codable {
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
struct Passesa: Codable {
    let total: Int?
    let key: Int?
    let accuracy: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case key = "key"
        case accuracy = "accuracy"
    }
}

// MARK: - Penalty
struct Penaltya: Codable {
    let won: Int?
    let commited: Int?
    let scored: Int?
    let missed: Int?
    let saved: Int?

    enum CodingKeys: String, CodingKey {
        case won = "won"
        case commited = "commited"
        case scored = "scored"
        case missed = "missed"
        case saved = "saved"
    }
}

// MARK: - Shots
struct Shotsa: Codable {
    let total: Int?
    let on: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case on = "on"
    }
}

// MARK: - Substitutes
struct Substitutesa: Codable {
    let substitutesIn: Int?
    let out: Int?
    let bench: Int?

    enum CodingKeys: String, CodingKey {
        case substitutesIn = "in"
        case out = "out"
        case bench = "bench"
    }
}

// MARK: - Tackles
struct Tacklesa: Codable {
    let total: Int?
    let blocks: Int?
    let interceptions: Int?

    enum CodingKeys: String, CodingKey {
        case total = "total"
        case blocks = "blocks"
        case interceptions = "interceptions"
    }
}

// MARK: - Team
struct Teama: Codable {
    let id: Int?
    let name: String?
    let logo: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case logo = "logo"
    }
}

typealias SinglePlayerDetails = [SinglePlayerDetail]


