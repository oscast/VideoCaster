//
//  VideoDetailViewModel.swift
//  VideoCaster
//
//  Created by Oscar Castillo on 10/24/22.
//

import Foundation
import GoogleCast

class VideoDetailViewModel: NSObject, ObservableObject, GCKSessionManagerListener, GCKRequestDelegate {
    
    let video: Video
    let sessionManager: GCKSessionManager
    
    init(video: Video, sessionManager: GCKSessionManager) {
        self.video = video
        self.sessionManager = sessionManager
    }
    
    func castVideo() {
        sessionManager.add(self)
        guard let source = video.sources.first, let mediaURL = URL(string: source) else { return }
        
        let metadata = GCKMediaMetadata()
        metadata.setString(video.title, forKey: kGCKMetadataKeyTitle)
        metadata.setString(video.videoDescription,
                           forKey: kGCKMetadataKeySubtitle)
        metadata.addImage(GCKImage(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg")!,
                                   width: 480,
                                   height: 360))
        
        let mediaInfoBuilder = GCKMediaInformationBuilder.init(contentURL: mediaURL)
        mediaInfoBuilder.streamType = GCKMediaStreamType.none;
        mediaInfoBuilder.contentType = "video/mp4"
        mediaInfoBuilder.metadata = metadata;
        let mediaInformation = mediaInfoBuilder.build()
        
        if let request = self.sessionManager.currentSession?.remoteMediaClient?.loadMedia(mediaInformation) {
            request.delegate = self
        }
    }
}
