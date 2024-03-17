//
//  leagueDetails.swift
//  football_ios
//
//  Created by Tanvir on 13/1/24.
//

import SwiftUI

struct leagueDetails: View {
    var leagueid : Int;
    var leagueName: String;
    var logo : String
    var season : Int

    
    @State var tabIndex = 0
    @State private var selectedTabName = "Fixture";
    var body: some View {
        VStack{
            customTabview(tabIndex: $tabIndex, tabName: $selectedTabName,listname:["Fixture", "Recent", "Standings", "Top Score"])
            if(selectedTabName == "Fixture") {
                leagueFixturePage(leagueid: leagueid, season: season)
            }
            else if (selectedTabName == "Recent"){
                leagueRecentPage(leagueid: leagueid, season: season)
            }
            else if (selectedTabName == "Standings"){
                LeagueStandingPage(leagueid: leagueid, season: season)
            }
            else if(selectedTabName == "Top Score") {
                leagueTopScorePage(leagueid: leagueid, season: season)
            }
         
            GoogleBannerAdView()
            
            
        }.onChange(of: tabIndex){i in
            
        }
    }
}


