//
//  ContentView.swift
//  VideoCaster
//
//  Created by Oscar Castillo on 10/22/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            CastButtonRepresentable()
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
