//
//  matchboxui.swift
//  football_ios
//
//  Created by Tanvir on 27/12/23.
//

import SwiftUI

struct matchboxui: View {
    @State private var isNextPageActive = true
    var match : MatchListElement? = nil;
    @ObservedObject var viewmodel = ViewModel()
    @State var showhighlight: Bool = false;
    @Environment(\.colorScheme) var colorScheme

    
    var body: some View {
        
        Button(action: {
            Router.shared.path.append(MatchID(id: (match?.fixture?.id)!))
        }, label: {
            VStack(spacing: 0) {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,spacing: 0){
//                    status(match: match)
                    team1(match: match)
                    score(match: match)
                    team2(match: match)
                }
                HStack(alignment: .center){
                    status(match: match)
                    if(showhighlight){
                        Image("live-tv").resizable().scaledToFit().frame(width: 20, height: 20)
                    }
                }
            }.buttonStyle(.plain).padding(.vertical,8).padding(.horizontal,10)
            
        })
        .foregroundColor(colorScheme == .dark ? .white : .black)
        .background(.white)
        .padding(.horizontal,10)
        .onAppear{
            highlightget{d in
                self.showhighlight = d
            }
        }
    }
    
    func highlightget(completion: @escaping (Bool) -> Void) {
        Task{
            let statusget = staticData()
            let locallive: LiveVideoByID? = try await viewmodel.localLiveVideoGet() ?? nil
            let ads : Ads? = try await viewmodel.loadFromLocalStoreAds() ?? nil
            if(ads != nil && locallive != nil){
                let matchbyid = ads!.streamByMatchID ?? 0
                let status = statusget.ftstatus(sort: match!.fixture!.status!.short ?? "FT")
                let liveVideo: [Live] = locallive!.live ?? []
                let availablematchid: Bool = liveVideo.contains { $0.matchid == match!.fixture!.id}

                if (status == "live" || status == "fix") && matchbyid == 1 && availablematchid {
                    completion(true)
                  } else {
                    completion(false)
                }
            }else{
                completion(false)
            }
            
        }
        
       
    }
}


struct status : View {
    var statusget = staticData();
    var match : MatchListElement? = nil;
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View{
        ZStack{
            if(statusget.ftstatus(sort: match!.fixture!.status!.short ?? "FT") == "live"){
                Text("\(match?.fixture?.status?.elapsed ?? 0)" )
                    .font(.system(size:  idiom == .pad ? 14 :12))
                    .padding(5).overlay(Circle().fill(Color.gray.opacity(0.1)))
            }  else {
                Text(match?.fixture?.status?.short == "CANC" ? "CN" : match?.fixture?.status?.short ??   "").font(.system(size:  idiom == .pad ? 14 :12)).padding(5).overlay(Circle().fill(Color.gray.opacity(0.1)))
            }
        }.frame(width: 50)
    }
}

struct team1: View {
    var match : MatchListElement? = nil;
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View {
        HStack{
            Text(match?.teams?.home?.name ?? "").lineLimit(1).font(.system(size: idiom == .pad ? 14 : 12))
            
            AsyncImage(url: URL(string: match?.teams?.home?.logo ?? "")){ image in
                image
                    .resizable()
                    .scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.1)
                }
                .frame(width: 20, height: 20)
                .cornerRadius(6)
        }.frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct team2: View {
    var match : MatchListElement? = nil;
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View {
        HStack(spacing: 5){
            AsyncImage(url: URL(string: match?.teams?.home?.logo ?? "")){ image in
                image
                    .resizable()
                    .scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.1)
                }
                .frame(width: 20, height: 20)
                .cornerRadius(6)
            
            Text(match?.teams?.away?.name ?? "").lineLimit(1).font(.system(size:idiom == .pad ? 14 :  12))
            
            
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct score: View {
    var statusget = staticData();
    let format = "yyyy-MM-dd'T'HH:mm:ssZ"
    var match : MatchListElement? = nil;
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View {
        HStack{
            if(statusget.ftstatus(sort: match!.fixture!.status!.short ?? "FT") == "fix"){
                let date = getDateFromString(match?.fixture?.date! ?? "", format: format)
                Text("\(formattedDate(date ?? Date(), format: "hh:mm a"))").font(.system(size:idiom == .pad ? 14 : 12))
            }else{
                Text("\(match?.goals?.home ?? 0)").font(.system(size:idiom == .pad ? 14 : 12))
                Text("-").font(.system(size:idiom == .pad ? 14 : 12))
                Text("\(match?.goals?.away ?? 0)").font(.system(size:idiom == .pad ? 14 : 12))
            }
            let date = getDateFromString(match?.fixture?.date! ?? "", format: format)
         
        }.frame(width: 80)
    }
    
    func getDateFromString(_ dateString: String, format: String) -> Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = format
           return dateFormatter.date(from: dateString)
    }

       // Function to format date as a string
    func formattedDate(_ date: Date, format: String) -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = format
           return dateFormatter.string(from: date)
    }
}


