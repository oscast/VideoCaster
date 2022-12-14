//
//  VideoList.swift
//  VideoCaster
//
//  Created by Oscar Castillo on 10/23/22.
//

import Foundation

// MARK: - VideoList
struct VideoList: Codable {
    let categories: [Category]
}

// MARK: - Category
struct Category: Codable, Identifiable {
    var id: String = UUID().uuidString
    let name: String
    let videos: [Video]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.videos = try container.decode([Video].self, forKey: .videos)
    }
}

// MARK: - Video
struct Video: Codable, Identifiable {
    var id: String = UUID().uuidString
    let videoDescription: String
    let sources: [String]
    let subtitle: Subtitle
    let thumb, title: String

    enum CodingKeys: String, CodingKey {
        case videoDescription = "description"
        case sources, subtitle, thumb, title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.videoDescription = try container.decode(String.self, forKey: .videoDescription)
        self.sources = try container.decode([String].self, forKey: .sources)
        self.subtitle = try container.decode(Subtitle.self, forKey: .subtitle)
        self.thumb = try container.decode(String.self, forKey: .thumb)
        self.title = try container.decode(String.self, forKey: .title)
    }
    
    init() {
        self.videoDescription = "Big Buck Bunny tells the story of a giant rabbit with a heart bigger than himself. When one sunny day three rodents rudely harass him, something snaps... and the rabbit ain't no bunny anymore! In the typical cartoon tradition he prepares the nasty rodents a comical revenge.\n\nLicensed under the Creative Commons Attribution license\nhttp://www.bigbuckbunny.org"
        self.sources = [""]
        self.subtitle = .byGoogle
        self.thumb = "https://storage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg"
        self.title = "Big Buck Bunny"
    }
}

enum Subtitle: String, Codable {
    case byBlenderFoundation = "By Blender Foundation"
    case byGarage419 = "By Garage419"
    case byGoogle = "By Google"
}
