//
//  apicall.swift
//  football_ios
//
//  Created by Tanvir on 28/12/23.
//

import Foundation
import SwiftUI
import Combine

class ViewModel : ObservableObject{
//    @Published var fixtures: MatchList = []
    @Published var fixtures : MatchFilterList = []
    @Published var loading : Bool = false;
    @Published var selectedDate = Date()
    
    
    // fixture match get
    func fixtureGet(status: String, date: String){
//        let date : String = formattedDate(selectedDate: selectedDate)
        loading = true;
        var request = URLRequest(url: URL(string: "\(EndPoint().fixture)\(date)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let fixturesdata = try JSONDecoder().decode(MatchList.self, from: data)
                DispatchQueue.main.sync{
                    if(status == "all"){
                      
                        self.fixtures = self.matchFilterbyleague(fixtures: fixturesdata)

                    }else{
                        let onlyFixture = fixturesdata.filter{ $0.fixture?.status?.short == status}
                        self.fixtures = self.matchFilterbyleague(fixtures: onlyFixture)

                    }
                    self.loading = false;
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
                self.loading = false;
            }
            
        }
        
        task.resume()
    }
    
    
    // live match get
    @Published var liveloading : Bool = false;
    @Published var totalLiveMatch : Int = 0;
    @Published var livematch: MatchFilterList = []
    func liveGet(){
        self.liveloading = true;
        var request = URLRequest(url: URL(string: "\(EndPoint().livematch)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let fixturesdata = try JSONDecoder().decode(MatchList.self, from: data)
                DispatchQueue.main.sync{
                    self.totalLiveMatch = fixturesdata.count
                    self.livematch = self.matchFilterbyleague(fixtures: fixturesdata)
                    self.liveloading = false;
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
                self.liveloading = false;
            }
            
        }
        
        task.resume()
    }
    
    // league get
    @Published var leagueloading : Bool = false;
    @Published var leagueList: LeagueList = []
    func leagueGet(){
        leagueloading = true;
        var request = URLRequest(url: URL(string: "\(EndPoint().league)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let fixturesdata = try JSONDecoder().decode(LeagueList.self, from: data)
                DispatchQueue.main.sync{
                    self.leagueList = fixturesdata
                    self.leagueloading = false;
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
                self.leagueloading = false;
            }
            
        }
        
        task.resume()
    }
    
    
    @Published var matchdetails : MatchDetails = [];
    @Published var detailsLoading : Bool = false;
    @Published var matchdetailsIteam : [String] = [];
    func matchDetailsGet(fixtureid: Int){
        detailsLoading = true;
        var request = URLRequest(url: URL(string: "\(EndPoint().matchdetails)\(fixtureid)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let fixturesdata = try JSONDecoder().decode(MatchDetails.self, from: data)
                DispatchQueue.main.sync{
                    self.matchdetailsIteam = [];
                    self.matchdetailsIteam.append("Poll")
                    if((!(fixturesdata.first?.events?.isEmpty)!)){
                        self.matchdetailsIteam.append("Event")
                    }
                    if((!(fixturesdata.first?.lineups?.isEmpty)!)){
                        self.matchdetailsIteam.append("Lineup")
                    }
                    if((!(fixturesdata.first?.players?.isEmpty)!)){
                        self.matchdetailsIteam.append("Player")
                    }
                    if((!(fixturesdata.first?.statistics?.isEmpty)!)){
                        self.matchdetailsIteam.append("Statistics")
                    }
                    
                    self.matchdetailsIteam.append("Head To Head")
                    self.matchdetails = fixturesdata
                    
                    self.detailsLoading = false;
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
                self.detailsLoading = false;
            }
            
        }
        
        task.resume()
    }
    
    
    
    
    @Published var headToHeadloading : Bool = false;
    @Published var headToHeadMatch: MatchList = []
    func headToHeadGet(teamid1: Int, teamid2: Int){
        headToHeadloading = true;
        var request = URLRequest(url: URL(string: "\(EndPoint().headTohead)\(teamid1)-\(teamid2)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let fixturesdata = try JSONDecoder().decode(MatchList.self, from: data)
                DispatchQueue.main.sync{
                    self.headToHeadMatch = fixturesdata
                    print(fixturesdata.count)
                    self.headToHeadloading = false;
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
                self.headToHeadloading = false;
            }
            
        }
        
        task.resume()
    }
    
    
    @Published var teamfixtureloading : Bool = false;
    @Published var teamFixtureMatch: MatchList = []
    func teamFixtureGet(teamid: Int, season: Int, status: String){
        teamfixtureloading = true;
        var request = URLRequest(url: URL(string: "\(EndPoint().teamFixture)team=\(teamid)/season=\(season)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let fixturesdata = try JSONDecoder().decode(MatchList.self, from: data)
                DispatchQueue.main.sync{
                    let onlyFixture = fixturesdata.filter{ $0.fixture?.status?.short == status}
                    self.teamFixtureMatch = onlyFixture
                    
                    self.teamfixtureloading = false;
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
                self.teamfixtureloading = false;
            }
            
        }
        
        task.resume()
    }
    
    @Published var teamInfoloading : Bool = false;
    @Published var teaminformation: TeamInformation = []
    func teamInformationGet(teamid: Int){
        teamInfoloading = true;
        var request = URLRequest(url: URL(string: "\(EndPoint().teamInformation)\(teamid)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let fixturesdata = try JSONDecoder().decode(TeamInformation.self, from: data)
                DispatchQueue.main.sync{
                    self.teaminformation = fixturesdata
                    self.teamInfoloading = false;
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
                self.teamInfoloading = false;
            }
            
        }
        
        task.resume()
    }
    
    @Published var teamPlayerloading : Bool = false;
    @Published var teamPlayer: TeamPlayer = []
    func teamPlayerGet(teamid: Int, season: Int){
        teamPlayerloading = true;
        var request = URLRequest(url: URL(string: "\(EndPoint().teamPlayer)season=\(season)/teamid=\(teamid)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let fixturesdata = try JSONDecoder().decode(TeamPlayer.self, from: data)
                DispatchQueue.main.sync{
                    self.teamPlayer = fixturesdata
                    self.teamPlayerloading = false;
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
                self.teamPlayerloading = false;
            }
            
        }
        
        task.resume()
    }
    
    
    @Published var teamStatisticloading : Bool = false;
    @Published var teamStatistic: TeamStatistic?;
    func teamStatisticGet(teamid: Int, season: Int, leagueid: Int){
        teamStatisticloading = true;
        var request = URLRequest(url: URL(string: "\(EndPoint().teamStatistic)league=\(leagueid)/team=\(teamid)/season=\(season)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let fixturesdata = try JSONDecoder().decode(TeamStatistic.self, from: data)
                DispatchQueue.main.sync{
                    self.teamStatistic = fixturesdata
                    self.teamStatisticloading = false;
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
                self.teamStatisticloading = false;
            }
            
        }
        
        task.resume()
    }
    
    
    @Published var leagueFixtureloading : Bool = false;
    
    @Published var leagueFixture: MatchFilterList = [];
    func leagueFixtureGet(season: Int, leagueid: Int, status: String){
        leagueFixtureloading = true;
        var request = URLRequest(url: URL(string: "\(EndPoint().leagueFixture)league=\(leagueid)/season=\(season)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let fixturesdata = try JSONDecoder().decode(MatchList.self, from: data)
                DispatchQueue.main.sync{
                    let onlyFixture = fixturesdata.filter{ $0.fixture?.status?.short == status}
                    self.leagueFixture = self.matchFilterbyDate(fixtures: onlyFixture)
                    self.leagueFixtureloading = false;
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
                self.leagueFixtureloading = false;
            }
            
        }
        
        task.resume()
    }
    
    
    @Published var leagueStandingloading : Bool = false;
    @Published var leagueStanding: LeagueStanding?;
    func leagueStandingGet(season: Int, leagueid: Int){
        leagueStandingloading = true;
        var request = URLRequest(url: URL(string: "\(EndPoint().leagueStanding)league=\(leagueid)/season=\(season)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let fixturesdata = try JSONDecoder().decode(LeagueStanding.self, from: data)
                DispatchQueue.main.sync{
                    
                    self.leagueStanding = fixturesdata
                    self.leagueStandingloading = false;
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
                self.leagueStandingloading = false;
            }
            
        }
        
        task.resume()
    }
    
    
    
    @Published var leagueTopScoreloading : Bool = false;
    @Published var leagueTopScore: LeagueTopScore?;
    func leagueTopScoreGet(season: Int, leagueid: Int){
        leagueStandingloading = true;
        var request = URLRequest(url: URL(string: "\(EndPoint().leagueTopPlayer)league=\(leagueid)/season=\(season)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let fixturesdata = try JSONDecoder().decode(LeagueTopScore.self, from: data)
                DispatchQueue.main.sync{
                    
                    self.leagueTopScore = fixturesdata
                    self.leagueTopScoreloading = false;
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
                self.leagueTopScoreloading = false;
            }
            
        }
        
        task.resume()
    }
    
    
    
    @Published var playerdetailsLoading : Bool = false;
    @Published var singlePlayerDetails: SinglePlayerDetails?;
    func singlePlayerDetails(season: Int, playerid: Int){
        leagueStandingloading = true;
        var request = URLRequest(url: URL(string: "\(EndPoint().singlePlayerDetails)player=\(playerid)/season=\(season)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let fixturesdata = try JSONDecoder().decode(SinglePlayerDetails.self, from: data)
                DispatchQueue.main.sync{
                    self.singlePlayerDetails = fixturesdata
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
                
            }
            
        }
        
        task.resume()
    }
    
    
    
    @Published var playersquad: PlayerSquad?;
    func playerSquadGet( playerid: Int){
        leagueStandingloading = true;
        var request = URLRequest(url: URL(string: "\(EndPoint().playerSquad)player=\(playerid)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let fixturesdata = try JSONDecoder().decode(PlayerSquad.self, from: data)
                DispatchQueue.main.sync{
                    self.playersquad = fixturesdata
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
                
            }
            
        }
        
        task.resume()
    }
    
    
    @Published var playerTransfer: PlayerTransfer?;
    func playerTransferGet(playerid: Int){
        
        var request = URLRequest(url: URL(string: "\(EndPoint().playerTransfer)player=\(playerid)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let fixturesdata = try JSONDecoder().decode(PlayerTransfer.self, from: data)
                DispatchQueue.main.sync{
                    self.playerTransfer = fixturesdata
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
            
        }
        
        task.resume()
    }
    
    
    @Published var playertrophy: PlayerTrophy?;
    func playerTrophyGet(playerid: Int){
        print(playerid)
        var request = URLRequest(url: URL(string: "\(EndPoint().playertrophy)player=\(playerid)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let fixturesdata = try JSONDecoder().decode(PlayerTrophy.self, from: data)
                DispatchQueue.main.sync{
                    self.playertrophy = fixturesdata
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
            
        }
        
        task.resume()
    }
    
    
    func playerInfrmationGet(season: Int, playerid: Int){
        print("\(season)")
        self.playerdetailsLoading = true;
        do {
            
            DispatchQueue.main.sync{
                singlePlayerDetails(season: season, playerid: playerid)
                playerSquadGet(playerid: playerid)
                playerTransferGet(playerid: playerid)
                playerTrophyGet(playerid: playerid)
                self.playerdetailsLoading = false;
            }
            
        } catch {
            print("Error decoding JSON: \(error)")
            self.playerdetailsLoading = false;
        }
    }
    
    
    // live stream
    @Published var livevideo1Loading : Bool = false;
    @Published var livevideoId : LiveVideoByID?;
    func liveVideoByIdGet() async {
        
        guard let url = URL(string: "\(EndPoint().liveVideobyId)") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decodedItems = try JSONDecoder().decode(LiveVideoByID.self, from: data)
            DispatchQueue.main.async {
                self.livevideoId = decodedItems
                self.storeLiveVideoid(livecideoid: decodedItems)
                var liveIdsList = "";
                for i in 1...(decodedItems.live?.count ?? 0){
                    let index = i-1
                    let datat = decodedItems.live?[index]
                    liveIdsList += "\(datat?.matchid ?? 1254)" + (index == ((self.livevideoId?.live?.count ?? 0) - 1) ? "" : "-")
                }
                
                self.multipleFixtureGet(fixtureid: liveIdsList)
            }
        } catch {
            print("Error fetching data: \(error)")
        }
        
        
        //        self.livevideo1Loading = true;
        //        var request = URLRequest(url: URL(string: "\(EndPoint().liveVideobyId)")!)
        //        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.httpMethod = "GET"
        //
        //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        //          guard let data = data else {
        //            print(String(describing: error))
        //            return
        //          }
        //            do {
        //                let fixturesdata = try JSONDecoder().decode(LiveVideoByID.self, from: data)
        //                DispatchQueue.main.sync{
        //                    self.livevideoId = fixturesdata
        //                    self.storeLiveVideoid(livecideoid: fixturesdata)
        //                    var liveIdsList = "";
        //                    for i in 1...(fixturesdata.live?.count ?? 0){
        //                        let index = i-1
        //                        let datat = fixturesdata.live?[index]
        //                        liveIdsList += "\(datat?.matchid ?? 1254)" + (index == ((self.livevideoId?.live?.count ?? 0) - 1) ? "" : "-")
        //                    }
        //
        //                    self.multipleFixtureGet(fixtureid: liveIdsList)
        //                }
        //
        //            } catch {
        //                self.livevideo1Loading = false;
        //                print("Error decoding JSON: \(error)")
        //            }
        //
        //        }
        //
        //        task.resume()
    }
    
    
    @Published var multipleFixture: MatchList = []
    func multipleFixtureGet(fixtureid: String){
        self.livevideo1Loading = true;
        var request = URLRequest(url: URL(string: "\(EndPoint().getMultipleFixture)\(fixtureid)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let fixturesdata = try JSONDecoder().decode(MatchList.self, from: data)
                DispatchQueue.main.sync{
                    self.multipleFixture = []
                    self.multipleFixture = fixturesdata
                    self.livevideo1Loading = false;
                    
                }
                
            } catch {
                self.livevideo1Loading = false;
                print("Error decoding JSON: \(error)")
            }
            
        }
        
        task.resume()
    }
    
    @Published var phpStreamLoading: Bool = false
    @Published var phpStreamData: PHPStream?
    func phpStreamGet(){
        self.phpStreamLoading = true;
        var request = URLRequest(url: URL(string: "\(EndPoint().phpstream)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            do {
                let fixturesdata = try JSONDecoder().decode(PHPStream.self, from: data)
                DispatchQueue.main.sync{
                    self.phpStreamData = fixturesdata
                    self.phpStreamLoading = false;
                    
                }
                
            } catch {
                self.phpStreamLoading = false;
                print("Error decoding JSON: \(error)")
            }
            
        }
        
        task.resume()
    }
    
    
    
    
    @Published var adsdata: Ads?
    func adsGet() async {
        //        var request =  URLRequest(url: URL(string: "\(EndPoint().adsjson)")!)
        //        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.httpMethod = "GET"
        //
        //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        //          guard let data = data else {
        //            print(String(describing: error))
        //            return
        //          }
        //            do {
        //                let fixturesdata = try JSONDecoder().decode(Ads.self, from: data)
        //                DispatchQueue.main.sync{
        //                    self.adsdata = fixturesdata
        //                    self.saveToLocalStore(adsdata: fixturesdata)
        //                }
        //
        //            } catch {
        //                print("Error decoding JSON: \(error)")
        //            }
        //
        //        }
        //
        //        task.resume()
        guard let url = URL(string: "\(EndPoint().adsjson)") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decodedItems = try JSONDecoder().decode(Ads.self, from: data)
            DispatchQueue.main.async {
                self.adsdata = decodedItems
                self.saveToLocalStore(adsdata: decodedItems)
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    
    
    // poll get
    @Published var matchpoll : Matchpoll?;
    @Published var pollloading : Bool = false;
    func getPoll(matchID: Int, home: Int, away: Int, homename: String, awayname: String, draw: Int) {
        print("sdjvsd \(EndPoint().pullget)\(matchID)");
        self.pollloading = true;
        var request = URLRequest(url: URL(string: "\(EndPoint().pullget)\(matchID)")!)
        request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            print(String(data: data, encoding: .utf8))
            do {
                
                let fixturesdata = try JSONDecoder().decode(Matchpoll.self, from: data)
                DispatchQueue.main.async {
                    
                    self.matchpoll = fixturesdata
                    
                    
                    if let poll = fixturesdata.poll, poll.isEmpty {
                        Task {
                            do {
                                try await self.pollUpdate(matchID: matchID, home: home, away: away, homename: homename, awayname: awayname, draw: draw)
                                 self.getPoll(matchID: matchID, home: home, away: away, homename: homename, awayname: awayname, draw: draw)
                                self.pollloading = false
                            } catch {
                                print("Error updating poll: \(error)")
                                self.pollloading = false
                            }
                        }
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.pollloading = false
                    print("Error decoding JSON: \(error)")
                }
            }
        }
        
        task.resume()
    }
    
    
    // pollupdate
    
    
    func pollUpdate(matchID: Int, home: Int, away: Int, homename: String, awayname: String, draw: Int) async {
        var request = URLRequest(url: URL(string: "\(EndPoint().pullUpdate)")!)
           request.addValue("live-soccer-tv-footballl-live-tv", forHTTPHeaderField: "ab")
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let parameters: [String: Any] = [
                "matchid": matchID,
                "home": home,
                "away": away,
                "draw": draw,
                "homename": homename,
                "awayname": awayname
            ]
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                let (data, _) = try await URLSession.shared.data(for: request)
                print(data)
              
            } catch {
                
            }
        }
    
    private func formattedDate( selectedDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: selectedDate)
    }
    func saveToLocalStore(adsdata: Ads) {
        UserDefaults.standard.removeObject(forKey: "ads")
        do {
            let encodedData = try JSONEncoder().encode(adsdata)
            UserDefaults.standard.set(encodedData, forKey: "ads")
        } catch {
            print("Error encoding data: \(error)")
        }
    }
    
    @Published var saveads: Ads?
    func loadFromLocalStoreAds() async throws -> Ads?  {
        if let savedData = UserDefaults.standard.data(forKey: "ads") {
            saveads = try await JSONDecoder().decode(Ads.self, from: savedData)
            return saveads;
        } else{
            return nil
        }
    }
    
    // match by id stream store
    func storeLiveVideoid(livecideoid: LiveVideoByID) {
        UserDefaults.standard.removeObject(forKey: "liveVideoId")
        do {
            let encodedData = try JSONEncoder().encode(livecideoid)
            UserDefaults.standard.set(encodedData, forKey: "liveVideoId")
        } catch {
            print("Error encoding data: \(error)")
        }
    }
    
    
    
    @Published var localLiveVideoId: LiveVideoByID?
    func localLiveVideoGet() async throws -> LiveVideoByID? {
        if let savedData = UserDefaults.standard.data(forKey: "liveVideoId") {
            return try await JSONDecoder().decode(LiveVideoByID.self, from: savedData)
        } else {
            // If no saved data is found, you may want to return a default value or throw an error
            return nil
        }
    }
    
    
    
    
    func matchFilterbyleague(fixtures: MatchList) -> MatchFilterList {
        var matchFilter : MatchFilterList = []
        var leagueid: [Int] = []
        for i in fixtures {
            if(!leagueid.contains(i.league?.id ?? 0)){
                leagueid.append(i.league?.id ?? 0)
            }
        }
        for i in leagueid {
            let data = fixtures.filter{ $0.league?.id == i }
            if(!data.isEmpty){
                matchFilter.append(MatchFilterleague(leagueId: i, date: data.first?.fixture?.date, MatchList: data))
            }
            
        }
        return matchFilter;
    }
    
    func matchFilterbyDate(fixtures: MatchList) -> MatchFilterList {
        var matchFilter : MatchFilterList = []
        var datelist: [String] = []
        for i in fixtures {
            var datedata = formattedDate((i.fixture?.date)!, format: "yyyy-MM-dd")
            if(!datelist.contains(datedata)){
                datelist.append(datedata)
            }
        }
        for i in datelist {
            let data = fixtures.filter{ formattedDate(($0.fixture?.date)!, format: "yyyy-MM-dd")  == i}
            if(!data.isEmpty){
                matchFilter.append(MatchFilterleague(leagueId: 0, date: i, MatchList: data))
            }
        }
        
        return matchFilter;
    }
    
    

       // Function to format date as a string
    func formattedDate(_ dateString: String, format: String) -> String {
        let mainformat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = getDateFromString(dateString, format: mainformat) ?? Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    func getDateFromString(_ dateString: String, format: String) -> Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = format
           return dateFormatter.date(from: dateString)
    }
}
