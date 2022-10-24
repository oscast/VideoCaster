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
                                .font(.title)
                            Spacer()
                        }
                        .padding()
                        
                        ForEach(category.videos) { video in
                            HStack {
                                AsyncImage(url: URL(string: video.thumb), content: { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 80)
                                }, placeholder: {
                                    Image("placeholder")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 80)
                                })
                                
                                Text(video.title)
                                
                                Spacer()
                            }
                            .onTapGesture {
                                viewModel.cast(video: video)
                            }
                        }
                        .padding()
                        
                    }
                    Spacer()
                }
                .navigationTitle("Video Caster Max")
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

struct HomeView_Previews: PreviewProvider {
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
