//
//  PlayerPage.swift
//  football_1
//
//  Created by Tanvir on 22/2/24.
//

//
//  DetailsplayerBox.swift
//  football_ios
//
//  Created by Tanvir on 8/1/24.
//

import SwiftUI

struct PlayerPage: View {
    @StateObject var viewmodel = ViewModel();
    @State private var selectedSegment = 0
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View {
        
        VStack{
            Picker(selection: $selectedSegment, label: Text("Segmented Control")) {
                ForEach(0..<(viewmodel.matchdetails.first?.players!.count)!, id: \.self){i in
                    let data = viewmodel.matchdetails.first?.players![i]
                    Text(data?.team?.name ?? "").lineLimit(1).font(.system(size: 13)).font(.system(size:idiom == .pad ? 16 : 12))
                    
                    
                }
            }.frame(width: 300)
            .pickerStyle(SegmentedPickerStyle())
            ForEach(0..<(viewmodel.matchdetails.first?.players![selectedSegment].players!.count)!, id: \.self){ i in
                let data2 = viewmodel.matchdetails.first?.players![selectedSegment].players![i]
                HStack{
                    AsyncImage(url: URL(string:data2?.player?.photo ?? "")){ image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Color.black.opacity(0.1)
                    }
                    .frame(width: 50, height: 50)
                    .cornerRadius(6)
                    
                    
                    Text((data2?.player?.name)!).font(.system(size:idiom == .pad ? 16 : 12))
                }.frame(maxWidth: .infinity, alignment: .leading).background(Color(.white)).cornerRadius(10).padding(.horizontal,10)
            }
            
        }
        
       
    }
}

#Preview {
    PlayerPage()
}
