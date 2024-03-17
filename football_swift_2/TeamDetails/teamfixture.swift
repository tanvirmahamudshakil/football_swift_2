//
//  teamfixture.swift
//  football_ios
//
//  Created by Tanvir on 11/1/24.
//

import SwiftUI

struct teamfixture: View {
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
                List(viewmodel.teamFixtureMatch, id: \.self) { i in
                    matchboxui(match: i)
                }
            }
            
            
        }.refreshable {
            viewmodel.teamFixtureGet(teamid: teamid, season: season, status: "NS")
        }
        .onAppear{
            print("sdvjbnsdkjvsdvsd")
            viewmodel.teamFixtureGet(teamid: teamid, season: season, status: "NS")
        }
        
        
    }
}


