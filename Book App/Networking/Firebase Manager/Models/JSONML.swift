//
//  JSONML.swift
//  Book App
//
//  Created by Shumakov Dmytro on 20.10.2023.
//

import Foundation

// MARK: - JSON Model -

struct JSONML: Codable {
    let books: [BookML]?
    let banners: [BannerML]?
    let suggestedIds: [Int]?

    enum CodingKeys: String, CodingKey {
        case books
        case banners = "top_banner_slides"
        case suggestedIds = "you_will_like_section"
    }
}

extension JSONML {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        books = try? values.decode([BookML].self, forKey: .books)
        banners = try? values.decode([BannerML].self, forKey: .banners)
        suggestedIds = try? values.decode([Int].self, forKey: .suggestedIds)
    }
}
