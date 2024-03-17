//
//  teamrecent.swift
//  football_ios
//
//  Created by Tanvir on 11/1/24.
//

import SwiftUI

struct teamrecent: View {
    @StateObject var viewmodel = ViewModel()
    var teamid : Int;
    var season : Int;
    var body: some View {
        ZStack{
            if(viewmodel.teamfixtureloading){
                ScrollView{
                    ProgressView("Loading...")
                }
            }else{
                if(viewmodel.teamFixtureMatch.isEmpty){
                    ScrollView{
                        Text("no Fixture Match Found")
                    }
                }else{
                    List(viewmodel.teamFixtureMatch, id: \.self) { i in
                        matchboxui(match: i)
                    }
                }
            }
            
            
        }.onAppear(perform: {
            viewmodel.teamFixtureGet(teamid: teamid, season: season, status: "FT")
        })
    }
}


