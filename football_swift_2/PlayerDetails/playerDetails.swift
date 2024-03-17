//
//  PlayerDetailsPage.swift
//  football_ios
//
//  Created by Tanvir on 16/1/24.
//

import SwiftUI

struct PlayerDetailsPage: View {
    @StateObject var viewmodel = ViewModel()
    var playerid : Int
    var season : Int
    
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View {
        VStack {
            List{
                HStack{
                    AsyncImage(url: URL(string: viewmodel.singlePlayerDetails?.first?.player?.photo ?? "")){ image in
                        image
                            .resizable()
                            .scaledToFit()
                        } placeholder: {
                            Color.gray.opacity(0.1)
                        }
                        .frame(width: 70, height: 70)
                        .cornerRadius(6)
                    VStack(alignment: .leading){
                        Text(viewmodel.singlePlayerDetails?.first?.player?.name ?? "").font(.system(size: 20)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text(viewmodel.singlePlayerDetails?.first?.player?.nationality ?? "")
                    }
                }
                
                Section(header: Text("Point Box")){
                    Text("Position: \(viewmodel.singlePlayerDetails?.first?.statistics?.first?.games?.position ?? "")")
                    Text("Number: \(viewmodel.singlePlayerDetails?.first?.statistics?.first?.games?.number ?? 0)")
                    Text("Appearences: \(viewmodel.singlePlayerDetails?.first?.statistics?.first?.games?.appearences ?? 0)")
                    Text("Lineups: \(viewmodel.singlePlayerDetails?.first?.statistics?.first?.games?.lineups ?? 0)")
                    Text("Minutes: \(viewmodel.singlePlayerDetails?.first?.statistics?.first?.games?.minutes ?? 0)")
                    Text("Rating: \(viewmodel.singlePlayerDetails?.first?.statistics?.first?.games?.rating ?? "")")
                    Text("Captain: \(viewmodel.singlePlayerDetails?.first?.statistics?.first?.games?.captain == true ? "Captain" : "")")
                    Text("Red Card: \(viewmodel.singlePlayerDetails?.first?.statistics?.first?.cards?.red ?? 0)")
                    Text("Yellow Card: \(viewmodel.singlePlayerDetails?.first?.statistics?.first?.cards?.yellow ?? 0)")
                    Text("Total Goals: \(viewmodel.singlePlayerDetails?.first?.statistics?.first?.goals?.total ?? 0)")
                    Text("Save Goals: \(viewmodel.singlePlayerDetails?.first?.statistics?.first?.goals?.saves ?? 0)")
                    
                }
                if(!(viewmodel.playertrophy?.isEmpty ?? false)) {
                    Section(header: Text("Trophies")){
                        ForEach(0..<(viewmodel.playertrophy?.count ?? 0), id: \.self){i in
                            let trophy = viewmodel.playertrophy![i]
                            VStack(alignment: .leading){
                                Text("League: \(trophy.league ?? "")")
                                Text("Country: \(trophy.country ?? "")")
                                Text("Place: \(trophy.place ?? "")")
                            }
                            
                        }
                        
                    }
                }
                
                Section(header: Text("Transfer")){
                    ForEach(0..<(viewmodel.playerTransfer?.first?.transfers?.count ?? 0), id: \.self){i in
                        let trophy = viewmodel.playerTransfer?.first?.transfers![i]
                        VStack(alignment: .leading){
                            Text("Date: \(trophy?.date ?? "")")
                            Text("In: \(trophy?.teams?.teamsIn?.name ?? "")")
                            Text("Out: \(trophy?.teams?.out?.name ?? "")")
                        }
                        
                    }
                    
                }
            }.onAppear(perform: {

    //            viewmodel.playerInfrmationGet(season: season, playerid: playerid)
            
                viewmodel.singlePlayerDetails(season: season, playerid: playerid)
                viewmodel.playerSquadGet(playerid: playerid)
                viewmodel.playerTrophyGet(playerid: playerid)
                viewmodel.playerTransferGet(playerid: playerid)
        })
       
            GoogleBannerAdView()
          
        }
    }
}

#Preview {
    PlayerDetailsPage(playerid: 35845, season: 2020)
}
