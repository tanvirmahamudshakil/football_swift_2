//
//  ContentView.swift
//  football_1
//
//  Created by Tanvir on 21/2/24.
//

import SwiftUI
import GoogleMobileAds

enum NavigationType : Hashable {
    case matchid(Int)
    case leages(League)
}

struct ContentView: View {
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    @State var showHomePage : Bool = false
    @StateObject var viewmodel = ViewModel()
    @State private var isSplashPresented = true
    @ObservedObject var router = Router.shared
    @Environment(\.scenePhase) private var scenePhase
    var body: some View {
        NavigationStack(path: $router.path){
            ZStack {
                if(!showHomePage){
                    splashScreen()
                }else{
                    if(viewmodel.adsdata?.google == 1) {
                        AppOpenAdView(openadsid: viewmodel.adsdata?.gopenAds ?? "")
                    }
                    
                    homepage(liveenable: viewmodel.adsdata?.streamByMatchIDPage != 0 ||  viewmodel.adsdata?.phpStream != 0 ? true : false)
                    .navigationDestination(for: pageRoute.self){i in
                        if(i.name == "live"){
                            LiveScore()
                        }else if (i.name == "league"){
                            LeaguePage()
                        }else if (i.name == "stream"){
                            LiveStream()
                        }
                    }.navigationDestination(for: MatchID.self){i in
                        matchDetailsPage(matchid: i.id)
                    }.navigationDestination(for:TeamID.self){r in
                        teamdetails(teamid: r.teamid ?? 33,
                        season: r.season ?? 2019,
                        name: r.name ?? "Premium",
                        logo: r.logo ?? "",
                        leagueid: r.leagueid ?? 39
                        )
                    }.navigationDestination(for: M3u8View.self){b in
                        M3u8Player(m3u8URLs: b.m3U8)
                    }.navigationDestination(for: WebView2.self){h in
                        WebView(urlString: h.url)

                    }
                    .navigationDestination(for: MorePage.self){i in
        //                if(i.name == "about"){
        //                    aboutPage()
        //                }else if (i.name == "privacy") {
        //                    PrivacyPolicyPage()
        //                }else{
        //                    termAndCondition()
        //                }
                    }.navigationDestination(for: LeagueID.self){routes in
                          leagueDetails(leagueid: routes.leagueid ?? 39, leagueName: routes.leagueName ?? "", logo: routes.logo ?? "", season: routes.season ?? 2019)
                    }
                }
            }
            .onAppear{
                Task{
                    await viewmodel.adsGet()
                    showHomePage = true
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
