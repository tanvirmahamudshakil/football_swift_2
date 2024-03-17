//
//  MatchFilter.swift
//  football_ios
//
//  Created by Tanvir on 23/1/24.
//

import Foundation

struct MatchFilterleague: Codable {
    let leagueId: Int?
    let date: String?
    let MatchList: MatchList?
}


typealias MatchFilterList = [MatchFilterleague]
