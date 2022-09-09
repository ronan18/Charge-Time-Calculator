//
//  ContentView.swift
//  Charge Time Calculator
//
//  Created by Ronan Furuta on 8/24/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appState = AppState()
    var body: some View {
        HomeScreen().environmentObject(appState)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
