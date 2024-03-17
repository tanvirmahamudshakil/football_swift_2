//
//  StatisticPage.swift
//  football_ios
//
//  Created by Tanvir on 9/1/24.
//

import SwiftUI

struct StatisticPage: View {
    @StateObject var viewmodel = ViewModel();
    @State private var progress: CGFloat = 0.5
    @State private var selectedSegment = 0
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View {
        let statistic = viewmodel.matchdetails.first!.statistics!
        VStack{
            Picker(selection: $selectedSegment, label: Text("Segmented Control")) {
                ForEach(0..<(statistic.count), id: \.self){i in
                    let singlestatic = statistic[i]
                    Text(singlestatic.team?.name ?? "").lineLimit(1).font(.system(size:idiom == .pad ? 16 : 12))
                }
            }
            .pickerStyle(SegmentedPickerStyle()).frame(width: 300)
            
            TopStaticBox(selectTeam: selectedSegment, staticsbox: statistic[selectedSegment])
            OtherStaticBox(selectTeam: selectedSegment, staticsbox: statistic)
        }
    }
}

struct TopStaticBox: View {
    var selectTeam : Int;
    var staticsbox : MatchDetailStatistic
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View{
        let persent = staticsbox.statistics?.filter{ String(describing: $0.value).lowercased().contains("%")};
        
        VStack(alignment: .leading){
            Section(header: Text("Top Statistics").padding(.horizontal,10)){
                ForEach(0..<persent!.count, id: \.self){i in
                    let data = persent![i]
                    let p = stringValue(value: data.value!).split(separator: "%").first
                    HStack{
                        CircularProgressView(progress: CGFloat(Double(p!)! / 100)).frame(width: 30,height: 30)
                        Text(data.type!).font(.system(size:idiom == .pad ? 16 : 12))
                    }.frame(maxWidth: .infinity, alignment: .leading).padding(5).background(.white).padding(.horizontal, 10)
                }
            }
        }
    }
    
    func stringValue(value : Value) -> String {
          switch value {
          case .string(let value):
              value
          case .integer(let value):
              "\(value)"
          case .null:
              "Nil"
          }
      }
}


struct OtherStaticBox: View {
    var selectTeam : Int;
    var staticsbox : [MatchDetailStatistic]
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View{
       
        
        
        let otherpercendage = staticsbox[selectTeam == 0 ? 0 : 1].statistics!.filter{ String(describing:$0.value).lowercased().contains("%") == false};
        let otherpercendage2 = staticsbox[selectTeam == 0 ? 1 : 0].statistics!.filter{ String(describing:$0.value).lowercased().contains("%") == false};
        
        VStack(alignment: .leading){
            Section(header: Text("Other Statistics").padding(.horizontal, 10)){
                ForEach(0..<otherpercendage.count, id: \.self){i in
                    let data3 = otherpercendage[i]
                    let data2 = otherpercendage2[i];
                               
                    VStack{
                        HStack {
                            LinearPercentIndicator(
                                percent: valueget(
                                    value1: data3.value == nil ? "0.0" : stringValue(value: data3.value!),
                                    value2: data2.value == nil ? "0.0" :  stringValue(value: data2.value!),
                                    value: data3.value == nil ? "0.0" :  stringValue(value: data3.value!)),
                                alignment: .leading
                            )
                            LinearPercentIndicator(
                                percent: valueget(
                                    value1: data2.value == nil ? "0.0" : stringValue(value: data2.value!),
                                    value2: data3.value == nil ? "0.0" :  stringValue(value: data3.value!),
                                    value: data2.value == nil ? "0.0" :  stringValue(value: data2.value!)),
                                alignment: .trailing
                            )
                        }
                       
                        Text(data3.type!).font(.system(size:idiom == .pad ? 16 : 12))
    //                    LinearPercentIndicator(percent: 0.5)
                   
                        
                    }.frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 10)
                    .onTapGesture {
                       
                    }
                }
            }
        }
    }
    
    func stringValue(value : Value) -> String {
          switch value {
          case .string(let value):
              value == "null" ? "0" : value
          case .integer(let value):
              "\(value)"
          case .null:
              "Nil"
          }
      }
    
    func valueget(value1 : String, value2 : String, value: String) -> CGFloat {
        
      if (value.contains("%")) {
          let data = value.split(separator: "%").first;
          return (CGFloat(Int(data!)!) / 100);
      } else if (value.contains(".")) {
          return (CGFloat(Double(value)!) /
                  (CGFloat(Double(value1 )!) + CGFloat(Double(value2 )!)));
      } else if (value1 == nil || value2 == nil || value == nil) {
          return (CGFloat(Int("0")!) / (CGFloat(Int("0")!) + CGFloat(Int("0")!)));
      } else {
          let sum = (CGFloat(Int(value1)!) + CGFloat(Int(value2)!));
         
        if (value == "0") {
          return 0.0;
        } else {
            return (CGFloat(Int(value)!)) / sum;
        }
      }
    }
}


struct LinearPercentIndicator: View {
    var percent: CGFloat
    var alignment : Alignment
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: alignment) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 5)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)
                
                Rectangle()
                    .frame(width: min(self.percent * geometry.size.width, geometry.size.width), height: 10)
                    .foregroundColor(Color.blue)
                    .cornerRadius(10)
                    .animation(.linear)
            }
        }
    }
}


struct CircularProgressView: View {
    var progress: CGFloat
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { UIDevice.current.orientation.isPortrait }
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 3.0)
                .opacity(0.3)
                .foregroundColor(Color.gray)

            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 3.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.blue)
                .rotationEffect(Angle(degrees: -90.0))
                .animation(.easeInOut)
            
//            Text(String(format: "%.0f%%", progress * 100.0))
//                .font(.title)
//                .fontWeight(.bold)
        }
        
    }
}

#Preview {
    StatisticPage()
}
