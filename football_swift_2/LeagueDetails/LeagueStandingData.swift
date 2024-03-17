//
//  leagueStandingPage.swift
//  football_ios
//
//  Created by Tanvir on 13/1/24.
//

import SwiftUI

struct LeagueStandingPage: View {
    @StateObject var viewmodel = ViewModel()
    var leagueid : Int
    var season : Int
    var listfilter = ["All", "Home", "Away"];
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    @State private var selectedSegment = 0
    var body: some View {
        ZStack{
            if(viewmodel.leagueStandingloading) {
                ScrollView{
                    ProgressView("Loading...")
                }
            }else{
                VStack{
                    Section{
                        Picker(selection: $selectedSegment, label: Text("Segmented Control")) {
                            ForEach(0..<listfilter.count, id: \.self){i in
                                Text(listfilter[i]).tag(i).font(.system(size:idiom == .pad ? 16 : 12))
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 320)
                    }
                 
                    List(viewmodel.leagueStanding?.first?.league?.standings ?? [], id: \.self){ i in
                        dataTableList(index: selectedSegment, standing: i, leagueinfo: (viewmodel.leagueStanding?.first?.league)!)
                    }
                }
            }
            
        }.refreshable {
            viewmodel.leagueStandingGet(season: season, leagueid: leagueid)
        }
        .onAppear(perform: {
            viewmodel.leagueStandingGet(season: season, leagueid: leagueid)
        })
    }
}


struct dataTableList: View {
    var index : Int
    var standing : [Standing];
    var leagueinfo : Leaguew
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View {
        Section{
            HStack{
                Text("\(leagueinfo.name ?? "")").font(.system(size: 12))
                Spacer()
                Text("MP").font(.system(size: 12)).font(.system(size:idiom == .pad ? 16 : 12))
                Text("GD").font(.system(size: 12)).font(.system(size:idiom == .pad ? 16 : 12))
                Text("PTS").font(.system(size: 12)).font(.system(size:idiom == .pad ? 16 : 12))
            }
            ForEach(standing, id: \.self){idata in
                if index == 0 {
                    dataList(alldata: idata.all!, standing: idata)
                } else if index == 1 {
                    dataList(alldata: idata.home!, standing: idata)
                }
                else {
                    dataList(alldata: idata.away!, standing: idata)
                }
            }
        }
    }
}


struct dataList: View {
    let alldata: All;
    let standing : Standing
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: standing.team?.logo ?? "")){ image in
                image
                    .resizable()
                    .scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.1)
                }
                .frame(width: 20, height: 20)
                .cornerRadius(6)
            Text(standing.team?.name ?? "").font(.system(size:idiom == .pad ? 16 : 12))
            Spacer()
            Text("\(alldata.played ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
            Text("\((alldata.goals!.goalsFor ?? 0) - (alldata.goals!.against ?? 0) )").font(.system(size:idiom == .pad ? 16 : 12))
            Text("\(((alldata.win ?? 0) * 3) + (alldata.draw ?? 0))").font(.system(size:idiom == .pad ? 16 : 12))
        }
    }
}





