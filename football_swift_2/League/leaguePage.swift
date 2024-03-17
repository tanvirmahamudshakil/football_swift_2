//
//  LeaguePage.swift
//  football_1
//
//  Created by Tanvir on 21/2/24.
//

import SwiftUI

struct LeaguePage: View {
    @StateObject var viewmodel = ViewModel()
    var body: some View {
        ZStack{
            Color(.systemGroupedBackground)
            VStack{
                if (viewmodel.leagueloading){
                    ProgressView("Loading...")
                }
                
                List(Array(viewmodel.leagueList.enumerated()), id: \.offset){index, i in
                    Button(action: {
                        Router.shared.path.append(LeagueID(leagueid: i.league.id, leagueName: i.league.name, logo: i.league.logo, season: i.seasons.last?.year ?? 2024))
                    }, label: {
                        HStack{
                            AsyncImage(url: URL(string: i.league.logo ?? "")) { image in
                            image
                            .resizable()
                            .scaledToFit()
                            } placeholder: {
                                Color.gray.opacity(0.8)
                            }
                            .frame(width: 30, height: 30)
                            .cornerRadius(6)
                            
                            Text(i.league.name ?? "").lineLimit(1).font(.system(size: 12)).bold()
                            
                        }.padding(.horizontal,10)
                    })
                }.listStyle(.plain)
                GoogleBannerAdView()
            }.navigationTitle("League")
            
        }.onAppear{
            viewmodel.leagueGet()
        }
    }
}

#Preview {
    LeaguePage()
}
