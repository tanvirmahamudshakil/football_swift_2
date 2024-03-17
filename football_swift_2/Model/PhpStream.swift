// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pHPStream = try? JSONDecoder().decode(PHPStream.self, from: jsonData)

import Foundation

// MARK: - PHPStream
struct PHPStream:Hashable, Codable {
    let enable: Int?
    let data: [Datum]?

    enum CodingKeys: String, CodingKey {
        case enable = "enable"
        case data = "data"
    }
}

// MARK: - Datum
struct Datum:Hashable,  Codable {
    let id: Int?
    let title: String?
    let imagea: String?
    let imageb: String?
    let teama: String?
    let teamb: String?
    let m3U8: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case imagea = "imagea"
        case imageb = "imageb"
        case teama = "teama"
        case teamb = "teamb"
        case m3U8 = "m3u8"
    }
}
