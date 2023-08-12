//
//  ContentView.swift
//  NeedRest
//
//  Created by Nataliia Shusta on 11/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUpTime = Date.now
    @State private var cofeeAnmmount = 1
    @State private var sleepAmmount = 8
    
    var body: some View {
        NavigationStack {
            Text("Wake")
                .navigationTitle("Better rest")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
