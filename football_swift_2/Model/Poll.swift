//
//  poll.swift
//  football_ios
//
//  Created by Tanvir on 28/1/24.
//

import Foundation


struct Matchpoll: Codable {
    var matchid: Int?
    var poll: [Poll]?
    var total: Int?

    enum CodingKeys: String, CodingKey {
        case matchid
        case poll
        case total
    }
}

struct Poll: Codable {
    var value: Int?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case value
        case name
    }
}
