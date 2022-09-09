//
//  HomeScreen.swift
//  Charge Time Calculator
//
//  Created by Ronan Furuta on 8/24/22.
//

import SwiftUI
import ChargeTimeUI

enum FocusedField:Hashable {
    case currentCharge
    case goalCharge
    case startTime
}
struct HomeScreen: View {
    @EnvironmentObject var appState: AppState
    @State var currentCharge:String = "20"
    @State var fullCharge: String = "90"
    @State var startTime: Date = Date()
    @State var endTime: String = "12:00pm"
    @FocusState var focused: FocusedField?
    var body: some View {
        NavigationView {
            VStack() {
                VStack() {
                    
                    HStack {
                        Text("Charge Calculator").font(.largeTitle).bold()
                        Spacer()
                        NavigationLink(destination: Text("settings"), label: {Image(systemName: "gear.circle").font(.title)})
                    }
                    HStack {
                        Text("An Arrival subsidiary").font(.subheadline).bold().foregroundColor(.gray)
                        Spacer()
                    }
                }
                
                Spacer()
                HStack (alignment: .bottom) {
                    VStack {
                        HStack {
                            Text("Current Charge:").font(.headline)
                            Spacer()
                        }
                        HStack {
                            TextField("Charge Level", text: $currentCharge).frame(width: 100).fixedSize(horizontal: true, vertical: false)
                                .textFieldStyle(.roundedBorder).keyboardType(.numberPad).font(.system(.body, design: .monospaced)).onSubmit {
                                    guard let level = Int(self.currentCharge) else {
                                        return
                                    }
                                    self.appState.setCurrentCharge(level)
                                }.onChange(of: self.appState.currentCharge, perform: {charge in
                                    self.currentCharge = String(charge)
                                }).onChange(of: self.currentCharge, perform: {charge in
                                    guard let level = Int(self.currentCharge) else {
                                        return
                                    }
                                    self.appState.setCurrentCharge(level)
                                }).focused(self.$focused, equals: .currentCharge).overlay(alignment: .trailing ,content: {
                                    Text("%").padding(.trailing)
                                })
                            
                            Spacer()
                        }
                    }
                    Spacer()
                    
                    
                    VStack {
                        HStack {
                            Spacer()
                            Text("Goal Charge:").font(.headline).multilineTextAlignment(.trailing)
                            
                        }.padding(.top)
                        HStack {
                            Spacer()
                            TextField("Goal Level", text: $fullCharge).frame(width: 100).fixedSize(horizontal: true, vertical: false)
                                .textFieldStyle(.roundedBorder).keyboardType(.numberPad).font(.system(.body, design: .monospaced)).onSubmit {
                                    guard let level = Int(self.fullCharge) else {
                                        return
                                    }
                                    self.appState.setGoalCharge(level)
                                }.onChange(of: self.fullCharge, perform: {fullCharge in
                                    guard let level = Int(self.fullCharge) else {
                                        return
                                    }
                                    self.appState.setGoalCharge(level)
                                }).onChange(of: self.appState.goalCharge, perform: {charge in
                                    self.fullCharge = String(charge)
                                })
                                .focused(self.$focused, equals: .goalCharge).overlay(alignment: .trailing ,content: {
                                    Text("%").padding(.trailing)
                                })
                            
                        }
                    }
                }
                
                HStack {
                    Text("Floor:").font(.headline)
                    Spacer()
                }.padding(.top)
                HStack {
                    FloorIcon(speed: .fullSpeed, action: {self.appState.setSpeed(speed: .fullSpeed)}, selected: self.appState.speed == .fullSpeed ? true : false)
                    Spacer()
                    FloorIcon(speed: .varies, action: {self.appState.setSpeed(speed: .varies)}, selected: self.appState.speed == .varies ? true : false)
                    Spacer()
                    FloorIcon(speed: .unkown, action: {self.appState.setSpeed(speed: .unkown)}, selected: self.appState.speed == .unkown ? true : false)
                }
                
                
                
                Spacer()
                Spacer()
                VStack {
                    HStack {
                        VStack {
                            HStack {
                                Text("Start Time:").font(.headline)
                                Spacer()
                            }.padding(.top)
                            HStack {
                                DatePicker(
                                    "Start Time",
                                    selection: self.$startTime,
                                    displayedComponents: [.hourAndMinute]
                                ).font(.headline).labelsHidden().onChange(of: self.startTime) {start in
                                    self.appState.setStartTime(start)
                                }.onAppear {
                                    self.startTime = self.appState.startTime
                                }.focused(self.$focused, equals: .startTime)
                                Spacer()
                                
                            }
                        }
                        Spacer()
                        VStack {
                            HStack {
                                Spacer()
                                Text("End:").font(.headline)
                                
                            }.padding(.top)
                            
                            
                            Text(self.appState.endTime, style: .time).font(.system(.largeTitle, design: .monospaced)).fontWeight(.heavy).lineLimit(1)
                            
                            
                        }
                    }
                    if #available(iOS 16.0, *) {
                        Gauge(value: Double(self.appState.currentCharge), in: 0...Double(self.appState.goalCharge)) {
                            //Text("BPM")
                            //Text("BPM")
                        } currentValueLabel: {
                            // Text("\(Int(self.appState.currentCharge))")
                        } minimumValueLabel: {
                            Text("\(Int(0))%")
                        } maximumValueLabel: {
                            Text("\(Int(self.appState.goalCharge))%")
                        }
                        //.gaugeStyle(.)
                    } else {
                        Text("")
                    }
                }
                Spacer()
            }.padding()
        } .onAppear {
            //UIScrollView.appearance().keyboardDismissMode = .interactive
        }  .simultaneousGesture(DragGesture().onChanged({ _ in
            self.focused = nil            }))
        .onTapGesture { // dissmis on tap as well
            self.focused = nil
        }
        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen().environmentObject(AppState())
    }
}
