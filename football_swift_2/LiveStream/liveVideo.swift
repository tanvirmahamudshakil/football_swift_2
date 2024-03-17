//
//  livevideo1.swift
//  football_ios
//
//  Created by Tanvir on 17/1/24.
//

import SwiftUI

struct Livevideo1: View {
    @StateObject var viewmodel = ViewModel()
    var adsviewcontroller = ViewController()
    @ObservedObject var router = Router.shared
    var body: some View {
        ZStack{
            if viewmodel.livevideo1Loading{
                ProgressView("Loading...")
            }
            List(viewmodel.multipleFixture, id: \.self){i in
                matchboxui2(viewmodel: viewmodel, newview: AnyView(Text("")), match: i)
            }
        }.refreshable {
           await viewmodel.liveVideoByIdGet()
        }
        .onAppear{
            Task{
                await viewmodel.liveVideoByIdGet()
//                adsviewcontroller.instantshow = true;
//                adsviewcontroller.viewDidLoad()
            }
        }
    }
}


struct matchboxui2: View {
    @StateObject var viewmodel = ViewModel()
    @State private var isNextPageActive = false
    @State private var isactive : Bool = false
    @State var newview : any View
    let matchDateformat = "yyyy-MM-dd'T'HH:mm:ssZ"
    var match : MatchListElement? = nil;
    var statusget = staticData();
    var secound : Int = 1800
    var secound2 : Int = 300
    var body: some View {
        let startDate = Date() // Replace with your actual start date
        let endDate = getDateFromString(dateString: (match!.fixture?.date)!, format: matchDateformat)!.addingTimeInterval(3600)
        let statusd = statusget.ftstatus(sort: match!.fixture!.status!.short ?? "FT")
        let timeDifferenceInSeconds = Int(endDate.timeIntervalSince(startDate))
        Button(action: {
            var live = viewmodel.livevideoId?.live?.filter{
                $0.matchid == match?.fixture?.id
            }
            let startDate = Date() // Replace with your actual start date
            let endDate = getDateFromString(dateString: (match!.fixture?.date)!, format: matchDateformat)!.addingTimeInterval(3600)
          
            if(!(live!.isEmpty)){
          
                let status = statusget.ftstatus(sort: match!.fixture!.status!.short ?? "FT")
                let timeDifferenceInSeconds = Int(endDate.timeIntervalSince(startDate))

                if(status != "live" && (timeDifferenceInSeconds - secound) <= 0){
                    if((live?.first?.m3U8?.first?.lowercased().hasSuffix(".m3u8")) != nil){
                        Router.shared.path.append(M3u8View(m3U8: live?.first?.m3U8 ?? []))
                        isactive = true
                    }else{
                        Router.shared.path.append(WebView2(url: live?.first?.m3U8?.first ?? ""))
                        isactive = true
                    }

                }else{
                    Router.shared.path.append(MatchID(id: match?.fixture?.id ?? 0))
                    isactive = true
                }
               
            }
        }, label: {
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,spacing: 0){
                status(match: match)
                Spacer()
                VStack{
                    HStack{
                        team1(match: match)
                        score(match: match)
                        team2(match: match)
                    }
                    
                    
                    if(statusd != "rec" && (timeDifferenceInSeconds - secound) <= 0 && (timeDifferenceInSeconds - secound2) >= 0) {
                        HStack{
                            Image("live-tv_white").resizable().scaledToFit().frame(width: 20)
                            Text("Live Soon").font(.system(size: 12))
                        }.padding(5).background(Color.red).foregroundColor(.white).cornerRadius(5)
                        
                        
                    }
                    if(statusd != "rec" && (timeDifferenceInSeconds - secound2) <= 0) {
                        HStack{
                            Image("live-tv_white").resizable().scaledToFit().frame(width: 20)
                            Text("Watch Live").font(.system(size: 12))
                        }.padding(5).background(Color.red).foregroundColor(.white).cornerRadius(5)
                        
                    }
                    if(statusd == "rec" && (timeDifferenceInSeconds - secound2) <= 0) {
                        HStack{
                            Image("live-tv_white").resizable().scaledToFit().frame(width: 20)
                            Text("\(match?.fixture?.status?.long ?? "")").font(.system(size: 12))
                        }.padding(5).background(Color.red).foregroundColor(.white).cornerRadius(5)
                        
                    }
//                    Image("live-tv").resizable().scaledToFit().frame(width: 20)
                }
               
            }
        })
    }
    
    
    
    

       // Function to format date as a string
       func formattedDate( dateString: String, format: String) -> String {
           let date = getDateFromString(dateString: dateString, format: matchDateformat)
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = format
           return dateFormatter.string(from: date ?? Date())
       }
    func getDateFromString( dateString: String, format: String) -> Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = format
           return dateFormatter.date(from: dateString)
       }
    
    
}

#Preview {
    Livevideo1()
}
