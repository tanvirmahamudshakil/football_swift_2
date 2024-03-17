//
//  teamStatiTicPage.swift
//  football_ios
//
//  Created by Tanvir on 12/1/24.
//

import SwiftUI

struct teamStatiTicPage: View {
    @StateObject var viewmodel = ViewModel()
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var teamid : Int;
    var season : Int;
    var leagueid : Int;
    var body: some View {
        ZStack{
            if(viewmodel.teamStatisticloading){
                ScrollView{
                    ProgressView("Loading...")
                }
            }
            List{
                Section(header: Text("Games")){
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())], content: {
                        Text("").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("Home").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("All").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("Away").font(.system(size:idiom == .pad ? 16 : 12))
                        
                        
                    })
                    
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())], content: {
                        // fast row
                        Text("Game Played").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.fixtures?.played?.home ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.fixtures?.played?.total ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.fixtures?.played?.away ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                        
                        
                    })
                    
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())], content: {
                        // wins row
                        Text("Wins").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.fixtures?.wins?.home ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.fixtures?.wins?.total ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.fixtures?.wins?.away ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                        
                        
                    })
                    
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())], content: {
                        // Draws row
                        Text("Draws").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.fixtures?.draws?.home ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.fixtures?.draws?.total ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.fixtures?.draws?.away ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                    })
                    
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())], content: {
                        // Loses row
                        Text("Loses").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.fixtures?.loses?.home ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.fixtures?.loses?.total ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.fixtures?.loses?.away ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                    })
                    
                    
                    
                    
                }
                Section(header: Text("Goals")){
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())], content: {
                        Text("").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("Home").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("All").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("Away").font(.system(size:idiom == .pad ? 16 : 12))
                        
                        
                    })
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())], content: {
                        // Loses row
                        Text("Goals For").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.goals?.goalsFor?.total?.home ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.goals?.goalsFor?.total?.total ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.goals?.goalsFor?.total?.away ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                    })
                    
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())], content: {
                        // Loses row
                        Text("Goals Against").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.goals?.against?.total?.home ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.goals?.against?.total?.total ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.goals?.against?.total?.away ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                    })
                }
                
                
                
                Section(header: Text("GOALS AVERAGE")){
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())], content: {
                        Text("").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("Home").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("All").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("Away").font(.system(size:idiom == .pad ? 16 : 12))
                        
                        
                    })
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())], content: {
                        // Loses row
                        Text("Goals For").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.goals?.goalsFor?.average?.home ?? "0")").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.goals?.goalsFor?.average?.total ?? "0")").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.goals?.goalsFor?.average?.away ?? "0")").font(.system(size:idiom == .pad ? 16 : 12))
                    })
                    
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())], content: {
                        // Loses row
                        Text("Goals Against").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.goals?.against?.average?.home ?? "0")").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.goals?.against?.average?.total ?? "0")").font(.system(size:idiom == .pad ? 16 : 12))
                        Text("\(viewmodel.teamStatistic?.goals?.against?.average?.away ?? "0")").font(.system(size:idiom == .pad ? 16 : 12))
                    })
                }
            }.listStyle(.insetGrouped).listRowInsets(.none)
            
            
        }.onAppear(perform: {
            viewmodel.teamStatisticGet(teamid: teamid, season: season, leagueid: leagueid)
        })
    }
}


