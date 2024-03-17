//
//  event.swift
//  football_ios
//
//  Created by Tanvir on 2/1/24.
//

import SwiftUI

struct EventPage: View {
    @StateObject var viewmodel = ViewModel();
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View {
        let homeid = self.viewmodel.matchdetails.first?.teams?.home?.id;
        let awayid = self.viewmodel.matchdetails.first?.teams?.away?.id;
        VStack{
            ForEach(0..<(viewmodel.matchdetails.first?.events?.count ?? 0), id: \.self){ i in
                let data = viewmodel.matchdetails.first?.events![i];
                HStack{
                    if(data?.type == "subst" && data?.team!.id == homeid){
                        HStack{
                            Image("change").resizable().scaledToFit().frame(width: 20,height: 20)
                            Text("\((data?.player?.name)!)").font(.system(size:idiom == .pad ? 16 : 12))
                        }.frame(maxWidth:.infinity, alignment: .trailing).listRowBackground(Color.blue)
                    } else if (data?.type == "Card" && data?.team!.id == homeid){
                        HStack{
                            Image("ic_card_m").resizable().scaledToFit().frame(width: 20,height: 20)
                            Text("\((data?.player?.name ?? "")!)").font(.system(size:idiom == .pad ? 16 : 12))
                        }.frame(maxWidth:.infinity,alignment: .trailing).listRowBackground(Color.blue)
                    }else if (data?.type == "Goal" && data?.team!.id == homeid){
                        HStack{
                            Image("ball").resizable().scaledToFit().frame(width: 20,height: 20)
                            Text("\((data?.player?.name)!)").font(.system(size:idiom == .pad ? 16 : 12))
                        }.frame(maxWidth:.infinity,alignment: .trailing).listRowBackground(Color.blue)
                    }else{
                        HStack{
                            
                        }.frame(maxWidth:.infinity,alignment: .trailing)
                    }
                    
                    Circle().foregroundColor(Color(.systemGroupedBackground)).overlay(Text("\((data?.time?.elapsed)!)").font(.system(size: idiom == .pad ? 16 : 12))).frame(maxWidth: 30)
                    if(data?.type == "subst" && data?.team!.id == awayid){
                        HStack{
                            Text("\((data?.player?.name)!)").font(.system(size:idiom == .pad ? 16 : 12))
                            Image("change").resizable().scaledToFit().frame(width: 20,height: 20)
                        }.frame(maxWidth:.infinity,alignment: .leading)
                    } else if (data?.type == "Card" && data?.team!.id == awayid){
                        HStack{
                            Text("\((data?.player?.name)!)").font(.system(size:idiom == .pad ? 16 : 12))
                            Image("ic_card_m").resizable().scaledToFit().frame(width: 20,height: 20)
                        }.frame(maxWidth:.infinity,alignment: .leading)
                    }
                    else if (data?.type == "Goal" && data?.team!.id == awayid){
                        HStack{
                            Text("\((data?.player?.name)!)").font(.system(size:idiom == .pad ? 16 : 12))
                            Image("ball").resizable().scaledToFit().frame(width: 20,height: 20)
                        }.frame(maxWidth:.infinity,alignment: .leading)
                    }else{
                        HStack{
                            
                        }.frame(maxWidth:.infinity,alignment: .leading)
                    }
                }.padding(.horizontal, 10).padding(.vertical, 5).background(.white).cornerRadius(10).padding(.horizontal, 10)
            }
        }
        
        
    }
}

#Preview {
    EventPage()
}
