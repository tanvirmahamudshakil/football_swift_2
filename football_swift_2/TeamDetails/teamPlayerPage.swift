//
//  teamPlayerPage.swift
//  football_ios
//
//  Created by Tanvir on 11/1/24.
//

import SwiftUI

struct teamPlayerPage: View {
    @StateObject var viewmodel = ViewModel()
    var teamid : Int;
    var season : Int;
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View {
        ZStack{
            if(viewmodel.teamPlayerloading){
                ScrollView{
                    ProgressView("Loading...")
                }
            }
            List{
                Section{
                    ForEach(viewmodel.teamPlayer, id: \.self){ i in
                        NavigationLink(destination: PlayerDetailsPage(playerid: i.player?.id ?? 35845, season: season)){
                            HStack{
                                AsyncImage(url: URL(string:i.player?.photo ?? "")){ image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    Color.gray.opacity(0.1)
                                }
                                .frame(width: 40, height: 40)
                                .cornerRadius(6)
                                
                                VStack(alignment: .leading){
                                    Text((i.player?.name)!).font(.system(size:idiom == .pad ? 16 : 12))
                                    Text("Age: \(i.player?.age ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))

                                }
                            }
                        }
                    }
                }
                
            }
            
        }.onAppear{
            viewmodel.teamPlayerGet(teamid: teamid, season: season)
        }
    }
}


