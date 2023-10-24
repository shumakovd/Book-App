//
//  BannerML.swift
//  Book App
//
//  Created by Shumakov Dmytro on 20.10.2023.
//

import Foundation


// MARK: - Banners Model -

struct BannersML: Codable {
    let banners: [BannerML]?

    enum CodingKeys: String, CodingKey {
        case banners = "top_banner_slides"
    }
}

extension BannersML {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        banners = try? values.decode([BannerML].self, forKey: .banners)
    }
}


// MARK: - Banner Model -

struct BannerML: Codable {
        
    let id: Int?
    let book_id: Int?
    let cover: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case book_id
        case cover
    }
}

extension BannerML {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decode(Int.self, forKey: .id)
        book_id = try? values.decode(Int.self, forKey: .book_id)
        cover = try? values.decode(String.self, forKey: .cover)
    }
}
