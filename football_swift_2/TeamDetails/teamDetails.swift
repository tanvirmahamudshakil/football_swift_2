//
//  teamdetails.swift
//  football_ios
//
//  Created by Tanvir on 11/1/24.
//

import SwiftUI

struct teamdetails: View {
    @State var teamid : Int;
    @State var season : Int;
    @State var name : String;
    @State var logo: String
    @State var leagueid: Int
    var adsviewcontroller = ViewController()
    
    @State var tabIndex = 0
    @State private var selectedTabName = "Fixture";
    var body: some View {
        VStack{
            customTabview(tabIndex: $tabIndex, tabName: $selectedTabName,listname:["Fixture", "Recent", "Information", "Statistic", "Player"])
            if(selectedTabName == "Fixture") {
                teamfixture(teamid: teamid, season: season)
            }else if (selectedTabName == "Recent"){
                teamrecent(teamid: teamid, season: season)
            }else if (selectedTabName == "Information"){
                teaminformation(teamid: teamid)
            }else if(selectedTabName == "Player") {
                teamPlayerPage(teamid: teamid, season: season)
            }else if(selectedTabName == "Statistic"){
                teamStatiTicPage(teamid: teamid, season: season, leagueid: leagueid)
            }
            Spacer()
       
            
        }.onChange(of: tabIndex){i in
            adsviewcontroller.viewDidLoad()
        }
    }
}

#Preview {
    teamdetails(teamid: 33, season: 2019, name: "ssdvsdsd", logo: "https://media.api-sports.io/football/leagues/39.png",leagueid: 39)
}
