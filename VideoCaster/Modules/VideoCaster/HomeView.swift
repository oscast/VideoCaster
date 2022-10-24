//
//  ContentView.swift
//  VideoCaster
//
//  Created by Oscar Castillo on 10/22/22.
//

import SwiftUI
import GoogleCast

struct HomeView: View {
    
    @ObservedObject var viewModel: VideoCasterViewModel
    
    init(viewModel: VideoCasterViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(viewModel.categories) { category in
                        HStack {
                            Text(category.name)
                            Spacer()
                        }
                        .padding()
                        
                        ForEach(category.videos) { video in
                            HStack {
                                Image(video.thumb)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                
                                Text(video.title)
                                
                                Spacer()
                            }
                        }
                        .padding()
                        
                    }
                    Spacer()
                }
                .navigationTitle("Welcome")
                .toolbar {
                    CastButtonRepresentable()
                        .padding(.trailing, 16)
                }
            }
        }
        .onAppear {
            viewModel.LoadVideos()
        }
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
