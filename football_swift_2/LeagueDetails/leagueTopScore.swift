//
//  leagueTopScorePage.swift
//  football_ios
//
//  Created by Tanvir on 13/1/24.
//

import SwiftUI

struct leagueTopScorePage: View {
    @StateObject var viewmodel = ViewModel()
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var leagueid : Int
    var season : Int
    var body: some View {
        ZStack{
            if(viewmodel.leagueTopScoreloading) {
                ScrollView{
                    ProgressView("Loading...")
                }
            }else{
                List{
                    Section{
                        ForEach(viewmodel.leagueTopScore ?? [], id: \.self){ i in
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
            
        }
        .refreshable {
            viewmodel.leagueTopScoreGet(season: season, leagueid: leagueid)
        }
        .onAppear(perform: {
            viewmodel.leagueTopScoreGet(season: season, leagueid: leagueid)
        })
    }
}


