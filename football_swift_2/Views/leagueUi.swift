//
//  LeagueUi.swift
//  football_ios
//
//  Created by Tanvir on 27/12/23.
//

import SwiftUI

//struct LeagueUi: View {
//    var fixturelist : MatchList = [];
//    var body: some View {
//        Section(header: HStack{
//            AsyncImage(url: URL(string: fixturelist.first?.league?.logo ?? "")) { image in
//                    image
//                        .resizable()
//                        .scaledToFit()
//                    } placeholder: {
//                        Color.gray.opacity(0.1)
//                    }
//                    .frame(width: 30, height: 30)
//                    .cornerRadius(6)
//            Text(fixturelist.first!.league!.name ?? "").lineLimit(1)
//        }){
//            ForEach(fixturelist, id: \.self){i in
//                matchboxui(match: i)
//            }
//        }.listRowSpacing(0)
//    }
//}




struct LeagueUi: View {
    var fixturelist : MatchFilterleague?;
    @State var showMatch : Bool = false;
    var body: some View {
//        Section(header: HStack{
//            AsyncImage(url: URL(string: fixturelist?.MatchList?.first?.league?.logo ?? "")) { image in
//                    image
//                        .resizable()
//                        .scaledToFit()
//                    } placeholder: {
//                        Color.gray.opacity(0.1)
//                    }
//                    .frame(width: 30, height: 30)
//                    .cornerRadius(6)
//            Text(fixturelist?.MatchList?.first?.league?.name ?? "").lineLimit(1)
//        }){
//            ForEach(fixturelist?.MatchList ?? [], id: \.self){i in
//                matchboxui(match: i)
//            }
//        }.listRowSpacing(0)
        
        VStack(spacing: 0){
            LeagueHeader(fixturelist: fixturelist,showMatch: $showMatch)
            if(showMatch) {
                ForEach(fixturelist?.MatchList ?? [], id: \.self){i in
                  matchboxui(match: i)
                RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.1))
                .frame(width: .infinity, height: 1)
                .border(Color.gray.opacity(0.1), width: 2)
                .padding(.horizontal,10)

                }
            }
        }
        
        
    }
}


struct LeagueHeader : View {
    var fixturelist : MatchFilterleague?;
    @Binding var showMatch: Bool
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: fixturelist?.MatchList?.first?.league?.logo ?? "")) { image in
            image
            .resizable()
            .scaledToFit()
            } placeholder: {
                Color.gray.opacity(0.8)
            }
            .frame(width: 30, height: 30)
            .cornerRadius(6)
            
            Text(fixturelist?.MatchList?.first?.league?.name ?? "").lineLimit(1).font(.system(size: 12)).bold()
            Spacer()
            Button(action: {
                withAnimation{
                    showMatch.toggle()
                }
            }, label: {
                Image("arrow_down")
                .resizable()
                .scaledToFit()
                .frame(width: 15)
            })
        }.frame(height: 40).padding(.horizontal,10).background(showMatch ? Color(.systemBackground):.white).padding(.horizontal,10)
    }
}


