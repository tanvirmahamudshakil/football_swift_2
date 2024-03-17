// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let liveVideoByID = try? JSONDecoder().decode(LiveVideoByID.self, from: jsonData)

import Foundation

// MARK: - LiveVideoByID
struct LiveVideoByID: Codable {
    let liveEnable: Int?
    let live: [Live]?

    enum CodingKeys: String, CodingKey {
        case liveEnable = "live_enable"
        case live = "Live"
    }
}

// MARK: - Live
struct Live: Codable {
    let matchid: Int?
    let m3U8: [String]?

    enum CodingKeys: String, CodingKey {
        case matchid = "matchid"
        case m3U8 = "m3u8"
    }
}
