// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let playerTrophy = try? JSONDecoder().decode(PlayerTrophy.self, from: jsonData)

import Foundation

// MARK: - PlayerTrophyElement
struct PlayerTrophyElement: Codable {
    let league: String?
    let country: String?
    let season: String?
    let place: String?

    enum CodingKeys: String, CodingKey {
        case league = "league"
        case country = "country"
        case season = "season"
        case place = "place"
    }
}

typealias PlayerTrophy = [PlayerTrophyElement]
