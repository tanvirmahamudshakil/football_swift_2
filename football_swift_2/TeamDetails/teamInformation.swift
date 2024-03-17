//
//  teaminformation.swift
//  football_ios
//
//  Created by Tanvir on 11/1/24.
//

import SwiftUI

struct teaminformation: View {
    @StateObject var viewmodel = ViewModel()
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var teamid : Int;
    var body: some View {
        ZStack{
            if(viewmodel.teamInfoloading){
                ScrollView{
                    ProgressView("Loading...")
                }
            }else{
                List(viewmodel.teaminformation, id: \.self){i in
                    Section(header: Text("Team Information")){
                        VStack(alignment: .leading){
                            Text("Team Name").font(.title3)
                            Text((i.team?.name)!).font(.system(size:idiom == .pad ? 16 : 12))
                        }
                        VStack(alignment: .leading){
                            Text("Team Code").font(.title3)
                            Text("\(i.team?.code ?? "")").font(.system(size:idiom == .pad ? 16 : 12))
                        }
                        VStack(alignment: .leading){
                            Text("Country").font(.title3)
                            Text(i.team?.country ?? "").font(.system(size:idiom == .pad ? 16 : 12))
                        }
                        
                    }
                    Section(header: Text("Venue")){
                        VStack(alignment: .leading){
                            Text("Name").font(.title3)
                            Text(i.venue?.name ?? "").font(.system(size:idiom == .pad ? 16 : 12))
                        }
                        VStack(alignment: .leading){
                            Text("Address").font(.title3)
                            Text(i.venue?.address ?? "").font(.system(size:idiom == .pad ? 16 : 12))
                        }
                        VStack(alignment: .leading){
                            Text("City").font(.title3)
                            Text(i.venue?.city ?? "").font(.system(size:idiom == .pad ? 16 : 12))
                        }
                        VStack(alignment: .leading){
                            Text("Surface").font(.title3)
                            Text(i.venue?.surface ?? "").font(.system(size:idiom == .pad ? 16 : 12))
                        }
                        
                    }
                }
            }
            
            
        }.onAppear(perform: {
            viewmodel.teamInformationGet(teamid: teamid)
        })
    }
}


