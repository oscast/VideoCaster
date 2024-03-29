//
//  VideoDetailView.swift
//  VideoCaster
//
//  Created by Oscar Castillo on 10/24/22.
//

import SwiftUI
import GoogleCast

struct VideoDetailView: View {
    
    @ObservedObject var viewModel: VideoDetailViewModel
    
    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                ScrollView {
                    VStack {
                        AsyncImage(url: URL(string: viewModel.video.thumb), content: { image in
                            image
                                .resizable()
                                .frame(maxWidth: .infinity)
                                .frame(height: screenWidth / 16.0 * 9.0)
                        }, placeholder: {
                            Image("placeholder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 80)
                        })

                        Text(viewModel.video.title)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                        Text(viewModel.video.videoDescription)
                            .font(.body)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding()
                }
                .frame(width: screenWidth, height: screenWidth)
                VideoControlView()
            }
        }
    }
}

struct VideoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = VideoDetailViewModel(video: Video())
        
        VideoDetailView(viewModel: viewModel)
    }
}
