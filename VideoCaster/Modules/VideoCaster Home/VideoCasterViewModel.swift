//
//  VideoCasterViewModel.swift
//  VideoCaster
//
//  Created by Oscar Castillo on 10/23/22.
//

import Foundation
import GoogleCast

class VideoCasterViewModel: NSObject, ObservableObject, GCKRequestDelegate, GCKSessionManagerListener {
    
    @Published var categories: [Category] = []
    
    var sessionManager: GCKSessionManager
    
    init(sessionManager: GCKSessionManager) {
        self.sessionManager = sessionManager
    }
    
    func LoadVideos() {
        if let path = Bundle.main.path(forResource: "Videos", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let videoList = try JSONDecoder().decode(VideoList.self, from: data)
                categories = videoList.categories
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
    func cast(video: Video) {
        sessionManager = GCKCastContext.sharedInstance().sessionManager
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
