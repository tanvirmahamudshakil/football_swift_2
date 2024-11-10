//
//  matchDetailsPage.swift
//  football_1
//
//  Created by Tanvir on 22/2/24.
//

import SwiftUI

struct matchDetailsPage: View {
    @StateObject var viewmodel = ViewModel()
    @State var selectTab: Int = 0
    @State var selectPage: String = "Poll"
    let matchid : Int
    var body: some View {
        ZStack{
            Color(.systemGroupedBackground)
            VStack(spacing: 0){
                if viewmodel.detailsLoading {
                    ProgressView("Loading...")
                }else{
                    MatchBox(matchdetails: viewmodel.matchdetails )
                    DetailsTabbarViewPage(selectTab: $selectTab, selectPage: $selectPage, pagename: viewmodel.matchdetailsIteam)
                    ScrollView{
                        if (selectPage == "Event") {
                            EventPage(viewmodel: viewmodel)
                        }else if (selectPage == "Lineup"){
                            LineupPage(viewmodel: viewmodel)
                        }else if (selectPage == "Player"){
                            PlayerPage(viewmodel: viewmodel)
                        }else if(selectPage == "Statistics") {
                            StatisticPage(viewmodel: viewmodel)
                        }else if (selectPage == "Head To Head"){
                            headTohead(viewmodel: viewmodel)
                        }else if (selectPage == "Poll") {
                            PollPage(viewmodel: viewmodel,matchdetails: viewmodel.matchdetails)
                        }
                    }
                }
                GoogleBannerAdView()
            }.navigationBarTitle("Details")
        }.onAppear{
            viewmodel.matchDetailsGet(fixtureid: matchid)
        }
    }
}


struct MatchBox : View {
     var matchdetails : MatchDetails
    var body: some View {
        HStack{
            Button(action: {
                Router.shared.path.append(TeamID(teamid: matchdetails.first?.teams?.home?.id, season: matchdetails.first?.league?.season, name: matchdetails.first?.teams?.home?.name, logo: matchdetails.first?.teams?.home?.logo, leagueid: matchdetails.first?.league?.id))
            }, label: {
                VStack{
                    AsyncImage(url: URL(string: matchdetails.first?.teams?.home?.logo ?? "")) { image in
                    image
                    .resizable()
                    .scaledToFit()
                    } placeholder: {
                        Color.gray.opacity(0.8)
                    }
                    .frame(width: 50, height: 50)
                    .cornerRadius(6)
                    Text(matchdetails.first?.teams?.home?.name ?? "")
                }.frame(maxWidth: .infinity)
            })
            
            detailsScoreBox(matchdetails: matchdetails)
            Button(action: {
                Router.shared.path.append(TeamID(teamid: matchdetails.first?.teams?.away?.id, season: matchdetails.first?.league?.season, name: matchdetails.first?.teams?.away?.name, logo: matchdetails.first?.teams?.away?.logo, leagueid: matchdetails.first?.league?.id))
            }, label: {
                VStack{
                    AsyncImage(url: URL(string: matchdetails.first?.teams?.away?.logo ?? "")) { image in
                    image
                    .resizable()
                    .scaledToFit()
                    } placeholder: {
                        Color.gray.opacity(0.8)
                    }
                    .frame(width: 50, height: 50)
                    .cornerRadius(6)
                    Text(matchdetails.first?.teams?.home?.name ?? "")
                }.frame(maxWidth: .infinity)
            })
        }.background(.white)
    }
}


struct detailsScoreBox: View {
    var statusget = staticData();
    let format = "yyyy-MM-dd'T'HH:mm:ssZ"
    var matchdetails : MatchDetails
    var body: some View {
        HStack{
            if(statusget.ftstatus(sort: matchdetails.first?.fixture!.status!.short ?? "FT") == "fix"){
            let date = getDateFromString(matchdetails.first?.fixture?.date! ?? "", format: format)
                CountdownTimerView(targetDate: date!)
            }else{
                Text("\(matchdetails.first?.goals?.home ?? 0)")
                Text("-")
                Text("\(matchdetails.first?.goals?.away ?? 0)")
            }
            let date = getDateFromString(matchdetails.first?.fixture?.date! ?? "", format: format)
        }
    }

}


struct DetailsTabbarViewPage : View {
    @Binding var selectTab: Int
    @Binding var selectPage: String
    let pagename : [String]
    var body: some View{
        ScrollViewReader{scrollViewProxy in
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    ForEach(Array(pagename.enumerated()), id: \.offset){index,i in
                        DetailsTextWidthReader(text: "\(i)",index: index,selectTab: $selectTab,scrollreader: scrollViewProxy,selectPage: $selectPage)
                    }
                }
            }
        }.background(.white)
    }
    func dateGenerate() -> [Date] {
        let calendar = Calendar.current
        var listdate : [Date] = []
        for i in 1...7 {
            listdate.append(calendar.date(byAdding: .day, value: (i-3), to: Date()) ?? Date())
        }
        return listdate
    }
    
    
    func dateBefore(days: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: -days, to: Date()) ?? Date()
    }
    
    func dateAfter(days: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: days, to: Date()) ?? Date()
    }
}

struct DetailsTextWidthReader: View {
    let text: String
    let index: Int
    @Binding var selectTab: Int
    var scrollreader : ScrollViewProxy
    @Binding var selectPage: String
    
    @State private var textWidth: CGFloat = .zero

    var body: some View {
        ZStack{
            Button(action: {
                withAnimation {
                selectPage = text;
                selectTab = index;
                    scrollreader.scrollTo(index, anchor: .center)
                }
               
            }, label: {
                Text(text)
                    .padding(.horizontal,5).foregroundColor(Color(selectTab == index ? .black:.systemGray)).font(.system(size: 13))
                    .background(GeometryReader { geometry in
                        Color.clear
                            .preference(key: SizePreferenceKey.self, value: geometry.size)
                    })
                    .onPreferenceChange(SizePreferenceKey.self) { preferences in
                        self.textWidth = preferences.width
                       
                }
            })
           
            if(selectTab == index) {
                VStack{
                    Spacer()
                    RoundedRectangle(cornerRadius: 10)
                       .fill(Color.black)
                   .frame(width: textWidth, height: 3)
                   .border(Color.black, width: 2)
                }
            }
        }.frame(height: 40)
    }
}





#Preview {
    matchDetailsPage(matchid: 978072)
}
