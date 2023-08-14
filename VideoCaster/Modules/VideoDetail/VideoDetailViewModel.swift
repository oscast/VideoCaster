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
    let sessionManager: GCKSessionManager = GCKCastContext.sharedInstance().sessionManager
    private var miniMediaControlsViewController: GCKUIMiniMediaControlsViewController?
    
    init(video: Video) {
        self.video = video
    }
    
    func castVideo() {
        let castContext = GCKCastContext.sharedInstance()
        miniMediaControlsViewController?.delegate = self
        
        sessionManager.add(self)
        guard let source = video.sources.first, let mediaURL = URL(string: source) else { return }
        
        let metadata = GCKMediaMetadata()
        metadata.setString(video.title, forKey: kGCKMetadataKeyTitle)
        metadata.setString(video.videoDescription,
                           forKey: kGCKMetadataKeySubtitle)
        if let url = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg") {
            metadata.addImage(GCKImage(url: url,
                                       width: 480,
                                       height: 360))
        }

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

extension VideoDetailViewModel: GCKUIMiniMediaControlsViewControllerDelegate {
    func miniMediaControlsViewController(_ miniMediaControlsViewController: GCKUIMiniMediaControlsViewController, shouldAppear: Bool) {
        true
    }
}
