//
//  liveStream.swift
//  football_ios
//
//  Created by Tanvir on 26/12/23.
//

import SwiftUI




struct LiveStream: View {
   
    @State var tabIndex = 0
    @State private var selectedSegment = 0
    @State private var selectedTabName = "Poll";
    @State private var video1 = 0
    @State private var video2 = 0
    @StateObject var viewmodel = ViewModel()
    @State private var liscreen : [String] = []
    @ObservedObject var router = Router.shared
  
    var body: some View {
        ZStack {
            VStack{
                Picker(selection: $selectedSegment, label: Text("Segmented Control")) {
                    ForEach(0..<liscreen.count, id: \.self){i in
                        Text(liscreen[i]).lineLimit(1).font(.system(size: 13)).tag(i)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 300)
                if(!liscreen.isEmpty && liscreen[selectedSegment] == "Live Video 1"){
                    Livevideo1()
                }else{
                    PhpStreamPage()
                }
                Spacer()
                GoogleBannerAdView()
               
            }
        }
        .navigationTitle("Live Match")
        .onAppear{
            Task{
                let ads : Ads? = try await viewmodel.loadFromLocalStoreAds()
                if(ads != nil){
                    self.video1 = ads!.streamByMatchIDPage ?? 0;
                    self.video2 = ads!.phpStream ?? 0;
                    liscreen.removeAll(keepingCapacity: true)
                    if(video1 == 1){
                        liscreen.append("Live Video 1")
                    }
                    if(video2 == 1){
                        liscreen.append("Live Video 2")
                    }
                }
            }
        }
    }
}


//    .navigationDestination(for: M3u8View.self){b in
//        m3u8Player(m3u8URLs: b.m3U8)
//    }
//    .navigationDestination(for: WebView2.self){f in
//        WebViewContainer(urlString: f.url)
//
//    }.navigationDestination(for: MatchID.self){f in
//        detailsPage(fixtureid:f.id!)
//    }
//    .navigationDestination(for:TeamID.self){r in
//    teamdetails(teamid: r.teamid ?? 33,
//    season: r.season ?? 2019,
//    name: r.name ?? "Premium",
//    logo: r.logo ?? "",
//    leagueid: r.leagueid ?? 39
//      )
//    }




#Preview {
    LiveStream()
}
