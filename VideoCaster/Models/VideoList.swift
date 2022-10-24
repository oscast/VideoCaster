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
}

enum Subtitle: String, Codable {
    case byBlenderFoundation = "By Blender Foundation"
    case byGarage419 = "By Garage419"
    case byGoogle = "By Google"
}
