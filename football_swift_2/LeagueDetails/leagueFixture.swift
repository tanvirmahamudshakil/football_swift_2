//
//  leagueFixturePage.swift
//  football_ios
//
//  Created by Tanvir on 13/1/24.
//

import SwiftUI

struct leagueFixturePage: View {
    @StateObject var viewmodel = ViewModel()

    let format = "yyyy-MM-dd'T'HH:mm:ssZ"
    var leagueid : Int
    var season : Int
    var body: some View {
        ZStack{
            if(viewmodel.leagueFixtureloading) {
                ScrollView{
                    ProgressView("Loading...")
                }
            }else{
                if(viewmodel.leagueFixture.isEmpty){
                    ScrollView{
                        Text("No Match Found")
                    }
                }else{
//                    let groupedData =  Dictionary(grouping: viewmodel.leagueFixture ?? [], by: {     $0.fixture?.date?.split(separator: "T").first })
                    List(0..<viewmodel.leagueFixture.count, id: \.self){ d in
                        let data = viewmodel.leagueFixture[d];
                        Section(header: Text(data.date ?? "")){
                            ForEach(data.MatchList ?? [], id: \.self){i in
                                matchboxui(match: i)
                            }
                        }
                        
                    }
                }
               
            }
            
        }.refreshable {
            viewmodel.leagueFixtureGet(season: season, leagueid: leagueid, status: "NS")
        }
        .onAppear(perform: {
            viewmodel.leagueFixtureGet(season: season, leagueid: leagueid, status: "NS")
        })
    }
    
    
    func getDateFromString(_ dateString: String, format: String) -> Date? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = format
           return dateFormatter.date(from: dateString)
       }

       // Function to format date as a string
       func formattedDate(_ date1: String, format: String) -> String {
           let dateFormatter = DateFormatter()
           let date = getDateFromString(date1 ?? "", format: format)
           dateFormatter.dateFormat = format
           return dateFormatter.string(from: date ?? Date())
       }
}

