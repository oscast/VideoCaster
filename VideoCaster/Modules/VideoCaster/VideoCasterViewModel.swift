//
//  VideoCasterViewModel.swift
//  VideoCaster
//
//  Created by Oscar Castillo on 10/23/22.
//

import Foundation
import GoogleCast

class VideoCasterViewModel: NSObject, ObservableObject {
    
    var sessionManager: GCKSessionManager
    
    init(sessionManager: GCKSessionManager) {
        self.sessionManager = sessionManager
    }
    
    func LoadVideos() {
        if let path = Bundle.main.path(forResource: "Videos", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                        
                        let jsonObj = try JSON(data: data)
                        print("jsonData:\(jsonObj)")
                        array = jsonObj["categories"][0]["videos"].arrayValue
                        tableView.reloadData()
                    } catch let error {
                        print("parse error: \(error.localizedDescription)")
                    }
                } else {
                    print("Invalid filename/path.")
                }
    }
}
