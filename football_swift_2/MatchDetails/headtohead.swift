//
//  headTohead.swift
//  football_ios
//
//  Created by Tanvir on 10/1/24.
//

import SwiftUI

struct headTohead: View {
    @StateObject var viewmodel = ViewModel()
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View {
        
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
            if viewmodel.headToHeadloading{
                ProgressView("Loading...")
            }else{
                ScrollView{
                    ForEach(viewmodel.headToHeadMatch, id: \.self){i in
                        matchboxui(match: i).padding(5)
                    }
                }
            }
            
        }.onAppear(perform: {
            viewmodel.headToHeadGet(teamid1: (viewmodel.matchdetails.first?.teams?.home?.id)!, teamid2: (viewmodel.matchdetails.first?.teams?.away?.id)!)
            
        
        })
    }
}

#Preview {
    headTohead()
}
