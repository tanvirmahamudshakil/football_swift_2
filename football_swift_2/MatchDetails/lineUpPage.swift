//
//  lineup.swift
//  football_ios
//
//  Created by Tanvir on 6/1/24.
//

import SwiftUI

struct LineupPage: View {
    @StateObject var viewmodel = ViewModel();
    @State var selectedTeam = 0;
    @State var selectedTeamID = 0;
    @State private var selectedSegment = 0
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View {
        let lineup = viewmodel.matchdetails.first?.lineups
        
        VStack {
            Picker(selection: $selectedSegment, label: Text("Segmented Control")) {
                ForEach(0..<(lineup!.count), id: \.self){i in
                    let singlelineup = lineup![i]
                    Text(singlelineup.team?.name ?? "").lineLimit(1).font(.system(size: 13)).font(.system(size:idiom == .pad ? 16 : 12))
                }
            }
            .pickerStyle(SegmentedPickerStyle()).frame(width: 300)
            LineUpdraw(viewmodel: viewmodel,selectedTeam: selectedSegment)
        }
        
        
    }
}



struct LineUpdraw : View {
    @StateObject var viewmodel = ViewModel();
     var selectedTeam = 0;
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View{
        let lineup = viewmodel.matchdetails.first?.lineups?[selectedTeam]
        var formetdata = lineup?.formation?.split(separator: "-");
        let formetdata2 = formetdata?.insert("1", at: 0)
        VStack{
            ZStack{
                Image("score").resizable().scaledToFill().frame(width: .infinity).padding(10).cornerRadius(10)
                VStack{
                    ForEach(formetdata!, id: \.self){i in
                        HStack{
                            ForEach(0..<Int(i)!, id: \.self){j in
                                let lineupgrid = "\(Int(i)! + 1):\(j + 1)"
                                let playerinfo = lineup?.startXI?.filter{$0.player?.grid == lineupgrid}
                                VStack(spacing:idiom == .pad ? 20 : 10){
                                    Circle().stroke(Color.black, lineWidth: 2).frame(width: 30).overlay(Text("\(playerinfo?.first?.player?.number ?? 0)"))
                                    Text("\(playerinfo?.first?.player?.name ?? "")").font(.system(size:idiom == .pad ? 16 : 12)).lineLimit(1).frame(width: 70)
                                }.padding(.leading, 10)
                            }
                        }
                    }
                    
                }
            }
            CoachData(lineup: lineup!)
            Substitutes(lineup: lineup!)
        }
    }
}



struct CoachData: View {
    var lineup : Lineup;
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View {
        VStack(alignment: .leading){
            Section(header: Text("Coaches")){
                HStack{
                    AsyncImage(url: URL(string:lineup.coach?.photo ?? "")){ image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Color.gray.opacity(0.1)
                    }
                    .frame(width: 30, height: 30)
                    .cornerRadius(6)
                    
                   
                    Text((lineup.coach?.name)!).font(.system(size:idiom == .pad ? 16 : 12))
                    Spacer()
                }.padding(5).background(Color(.white)).cornerRadius(10)
            }
        }.padding(.horizontal, 10)
    
    }
}

struct Substitutes: View {
    var lineup : Lineup;
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View {
        VStack(alignment: .leading){
            Section(header: Text("Substitutes")){
                ForEach(0..<lineup.substitutes!.count, id: \.self){i in
                    var data = lineup.substitutes![i]
                    Text((data.player?.name)!).padding(10).font(.system(size:idiom == .pad ? 16 : 12)).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading).background(Color(.white)).cornerRadius(10)
                    
                }
            }
        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading).padding()
        
    }
}

#Preview {
    LineupPage()
}
