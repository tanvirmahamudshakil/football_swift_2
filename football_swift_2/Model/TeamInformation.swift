//
//  teamInformation.swift
//  football_ios
//
//  Created by Tanvir on 11/1/24.
//




// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let teamInformation = try? JSONDecoder().decode(TeamInformation.self, from: jsonData)

import Foundation

// MARK: - TeamInformationElement
struct TeamInformationElement: Hashable, Codable {
    let team: Teamq?
    let venue: Venueq?
}

// MARK: - Team
struct Teamq:Hashable, Codable {
    let id: Int?
    let name, code, country: String?
    let founded: Int?
    let national: Bool?
    let logo: String?
}

// MARK: - Venue
struct Venueq:Hashable, Codable {
    let id: Int?
    let name, address, city: String?
    let capacity: Int?
    let surface: String?
    let image: String?
}

typealias TeamInformation = [TeamInformationElement]
