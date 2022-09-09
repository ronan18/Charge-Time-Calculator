//
//  FloorIcon.swift
//  ChargeTimeUI
//
//  Created by Ronan Furuta on 8/24/22.
//

import SwiftUI
import ChargeTimeLogic


public struct FloorIcon: View {
    @Environment(\.colorScheme) var colorScheme
    @State var foregroundColor:Color = .white
    @State var backgroundColor: Color = .black
    var speed: ChargeSpeed
    var floor: String
    var selected: Bool = false
    var action: ()->()
    
    public init(speed: ChargeSpeed, action: @escaping ()->() = {}, selected: Bool = false) {
        self.speed = speed
        self.floor = ChargeLogic().getFloorFromSpeed(speed: speed)
        self.action = action
        self.selected = selected
    }
   public var body: some View {
       Button(action: {self.action()}) {
           VStack {
               Spacer()
               Text(floor).font(.headline)
               Spacer()
               Text(self.speed.rawValue).font(.system(.caption, design: .monospaced))
           }.frame(width: 75, height: 100).padding().border(.gray).background(selected ? backgroundColor : foregroundColor).foregroundColor(selected ? foregroundColor : backgroundColor)
       }.onChange(of: self.colorScheme, perform: {scheme in
           switch scheme {
           case .light:
               self.foregroundColor = .white
               self.backgroundColor = .black
           case .dark:
               self.foregroundColor = .black
               self.backgroundColor = .white
           @unknown default:
               self.foregroundColor = .white
               self.backgroundColor = .black
           }
       })
    }
}

struct FloorIcon_Previews: PreviewProvider {
    static var previews: some View {
        FloorIcon(speed: .fullSpeed, action: {}, selected: false)
    }
}
