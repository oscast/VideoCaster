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
            VStack {
                Image(viewModel.video.thumb)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: screenWidth / 16.0 * 9.0)
                Text(viewModel.video.title)
                    .font(.largeTitle)
                    .padding()
                Text(viewModel.video.videoDescription)
                    .font(.body)
                Spacer()
            }
            .padding()
        }
    }
}

struct VideoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sessionManager = GCKCastContext.sharedInstance().sessionManager
        let viewModel = VideoDetailViewModel(video: Video(), sessionManager: sessionManager)
        
        VideoDetailView(viewModel: viewModel)
    }
}
