//
//  VideoCasterViewModel.swift
//  VideoCaster
//
//  Created by Oscar Castillo on 10/23/22.
//

import Foundation
import GoogleCast

class VideoCasterViewModel: NSObject, ObservableObject {
    
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
}
