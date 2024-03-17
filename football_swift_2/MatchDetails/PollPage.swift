//
//  PollPage.swift
//  football_ios
//
//  Created by Tanvir on 29/1/24.
//

import SwiftUI

struct PollPage: View {
    @StateObject var viewmodel = ViewModel();
     var matchdetails : MatchDetails = [];
    @State private var selectedOption: String = "Option 1"
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var totalvote: Int = 0;
    var body: some View {
        let matchidget = UserDefaults.standard.integer(forKey: "pollmatchid")
        VStack{
            HStack {
                Text("Pick your winner").font(.title2).font(.system(size:idiom == .pad ? 20 : 12))
                Spacer()
                Text("Total \(totalvoteget())").font(.title2).font(.system(size:idiom == .pad ? 16 : 12))
                
            }
            if matchidget == 0 {
                HStack{
                    VStack{
                        Circle().stroke(Color.blue, lineWidth: 2)
                            .frame(width: 50, height: 50).overlay(Text("Home"))
                        if viewmodel.matchpoll?.poll != nil{
                            Text("\(viewmodel.matchpoll?.poll![0].name ?? "")").font(.system(size:idiom == .pad ? 16 : 12))
                        }
                    }.frame(maxWidth: .infinity)
                    .onTapGesture {
                       
                        voteUpdate(matchID: matchdetails.first?.fixture?.id ?? 0, home: 1, away: 0, homename: matchdetails.first?.teams?.home?.name ?? "", awayname: matchdetails.first?.teams?.away?.name ?? "", draw: 0)
                    }
                    VStack{
                        Circle().stroke(Color.blue, lineWidth: 2)
                            .frame(width: 50, height: 50).overlay(Text("X"))
                        if viewmodel.matchpoll?.poll != nil{
                            Text("\(viewmodel.matchpoll?.poll![2].name ?? "")").font(.system(size:idiom == .pad ? 16 : 12))
                        }
                    }.frame(maxWidth: .infinity)
                    .onTapGesture {
                        voteUpdate(matchID: matchdetails.first?.fixture?.id ?? 0, home: 0, away: 0, homename: matchdetails.first?.teams?.home?.name ?? "", awayname: matchdetails.first?.teams?.away?.name ?? "", draw: 1)
                    }
                    VStack{
                        Circle().stroke(Color.blue, lineWidth: 2)
                            .frame(width: 50, height: 50).overlay(Text("Away"))
                        if viewmodel.matchpoll?.poll != nil{
                            Text("\(viewmodel.matchpoll?.poll![1].name ?? "")").font(.system(size:idiom == .pad ? 16 : 12))
                        }
                    }.frame(maxWidth: .infinity)
                    .onTapGesture {
                        voteUpdate(matchID: matchdetails.first?.fixture?.id ?? 0, home: 0, away: 1, homename: matchdetails.first?.teams?.home?.name ?? "", awayname: matchdetails.first?.teams?.away?.name ?? "", draw: 0)
                    }
                }
            } else{
                if viewmodel.matchpoll?.poll != nil{
                    VStack(alignment: .leading) {
                        Text("\(viewmodel.matchpoll?.poll![0].name ?? "")").font(.system(size:idiom == .pad ? 16 : 12))
                        HStack(alignment: .top) {
                            LinearPercentIndicator(percent: CGFloat(getPercentage(polldata:  viewmodel.matchpoll?.poll?[0])),alignment: .leading).frame(height: 5)
                            Text("\(viewmodel.matchpoll?.poll?[0].value ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                        }
                    }
                    
                }
                if viewmodel.matchpoll?.poll != nil{
                    VStack(alignment: .leading) {
                        Text("\(viewmodel.matchpoll?.poll![2].name ?? "")").font(.system(size:idiom == .pad ? 16 : 12))
                        HStack {
                            LinearPercentIndicator(percent: CGFloat(getPercentage(polldata:  viewmodel.matchpoll?.poll?[2])),alignment: .leading).padding(.top, 7)
                            Text("\(viewmodel.matchpoll?.poll?[2].value ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                        }
                    }
                    
                }
                if viewmodel.matchpoll?.poll != nil{
                    VStack(alignment: .leading) {
                        Text("\(viewmodel.matchpoll?.poll![1].name ?? "")").font(.system(size:idiom == .pad ? 16 : 12))
                        HStack {
                            LinearPercentIndicator(percent: CGFloat(getPercentage(polldata:  viewmodel.matchpoll?.poll?[1])),alignment: .leading).padding(.top, 7)
                            Text("\(viewmodel.matchpoll?.poll?[2].value ?? 0)").font(.system(size:idiom == .pad ? 16 : 12))
                        }
                        
                    }
                    
                }
                
            }
            
        }
        .padding(10)
        .background(.white)
        .padding(10)
        .onAppear{
            viewmodel.getPoll(matchID: matchdetails.first?.fixture?.id ?? 0, home: 1, away: 1, homename: matchdetails.first?.teams?.home?.name ?? "", awayname: matchdetails.first?.teams?.away?.name ?? "", draw: 1)
        }
    }
    
    func totalvoteget() -> Int {
        var totalvote: Int = 0;
        for i in 1...(viewmodel.matchpoll?.poll?.count ?? 1) {
            if(viewmodel.matchpoll?.poll![i-1].value != nil){
            totalvote = totalvote + (viewmodel.matchpoll?.poll![i-1].value ?? 0)
          }
            
        }
        return totalvote
    }
    
    func voteUpdate(matchID: Int, home: Int, away: Int, homename: String, awayname: String, draw: Int) {
        UserDefaults.standard.set(matchID, forKey: "pollmatchid")
        Task{
            await viewmodel.pollUpdate(matchID:matchID, home:home,away:away,homename:homename,awayname:awayname, draw:draw)
            viewmodel.getPoll(matchID:matchID, home:home,away:away,homename:homename,awayname:awayname, draw:draw)
        }
    }
    
    func getPercentage(polldata : Poll?) -> CFloat {
        let total = totalvoteget()
       
        let percent = ((Double(polldata?.value ?? 0) / Double(total)) * 100) / 100;
        
        return CFloat(percent)
    }
}

#Preview {
    PollPage()
}
