//
//  ContentView.swift
//  VideoCaster
//
//  Created by Oscar Castillo on 10/22/22.
//

import SwiftUI
import GoogleCast

struct HomeView: View {
    
    let viewModel: VideoCasterViewModel
    
    init(viewModel: VideoCasterViewModel) {
        self.viewModel = viewModel
    }
    
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
        let viewModel =
        VideoCasterViewModel(
            sessionManager:
                GCKCastContext
                .sharedInstance()
                .sessionManager)
        HomeView(viewModel: viewModel)
    }
}
