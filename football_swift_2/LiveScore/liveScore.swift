//
//  LiveScore.swift
//  football_1
//
//  Created by Tanvir on 21/2/24.
//

import SwiftUI

struct LiveScore: View {
    @StateObject var viewmodel = ViewModel()
     var adsview = ViewController()
    var body: some View {
        ZStack{
            Color(.systemGroupedBackground)
            VStack {
                if (viewmodel.liveloading){
                    ProgressView("Loading...")
                }
                ScrollView{
                    ForEach(0..<viewmodel.livematch.count, id: \.self){ d in
                        LeagueUi(fixturelist: viewmodel.livematch[d])
                    }
                }
                GoogleBannerAdView()
            }
        }.navigationTitle("Live Match")
        .onAppear{
            viewmodel.liveGet()
            adsview.viewDidLoad()
        }
    }
}

#Preview {
    LiveScore()
}
