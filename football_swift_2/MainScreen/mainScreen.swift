//
//  mainScreen.swift
//  football_ios
//
//  Created by Tanvir on 26/12/23.
//

import SwiftUI


struct mainScreen: View {
    @State private var selectedTab = 0
    @StateObject var viewmodel = ViewModel()
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }

    var body: some View {
  
        TabView(selection:$selectedTab){
            homepage().tabItem {
                Label("Home",systemImage: "house")}
            LiveScore()
                .tabItem {
                    Label("Live",systemImage: "calendar")
                }.tag(1)
            LiveStream()
                .tabItem {
                    Label("Live",systemImage: "livephoto")
                }.tag(2)
            LeaguePage()
                .tabItem {
                    Label("League",systemImage: "pencil.tip.crop.circle.badge.minus")
                }.tag(3)
            MenuPage()
                .tabItem {
                    Label("Menu",systemImage: "ellipsis.rectangle.fill")
                }.tag(4)
        }
        .onChange(of: selectedTab){i in
//            ViewController().viewDidLoad()
        }
        .onAppear{
            Task{
                let ads : Ads? = try await viewmodel.loadFromLocalStoreAds()
                if(ads != nil){
//                    self.video1 = viewmodel.saveads?.streamByMatchIDPage ?? 0;
//                    self.video2 = viewmodel.saveads?.phpStream ?? 0;
//                    self.openadsid = viewmodel.saveads?.gopenAds
//                    self.googlealow = viewmodel.saveads?.google ?? 0
                }
            }
    }
    
    }
}

#Preview {
    mainScreen()
}
