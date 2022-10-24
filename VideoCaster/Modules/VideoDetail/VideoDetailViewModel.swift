//
//  VideoDetailViewModel.swift
//  VideoCaster
//
//  Created by Oscar Castillo on 10/24/22.
//

import Foundation
import GoogleCast

class VideoDetailViewModel: NSObject, ObservableObject {
    
    let video: Video
    let sessionManager: GCKSessionManager
    
    init(video: Video, sessionManager: GCKSessionManager) {
        self.video = video
        self.sessionManager = sessionManager
    }
    
    func castVideo() {
        
    }
}
