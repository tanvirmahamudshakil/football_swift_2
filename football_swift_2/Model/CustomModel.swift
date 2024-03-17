//
//  custommodel.swift
//  football_ios
//
//  Created by Tanvir on 30/1/24.
//

import Foundation
import SwiftUI


struct MatchID: Hashable {
    let id: Int
}

struct M3u8View: Hashable {
    let m3U8: [String]
}

struct WebView2: Hashable {
    let url: String
}


struct TeamID: Hashable {
    let teamid: Int?
    let season: Int?
    let name: String?
    let logo: String?
    let leagueid: Int?
}

struct LeagueID: Hashable {
  let leagueid: Int?
  let  leagueName: String?
  let logo: String?
  let season: Int?
}


struct MorePage: Hashable {
    let name: String?
    
}

struct pageRoute: Hashable {
    let name: String?
    
}
