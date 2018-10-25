//
//  catalogue.swift
//  VideoCatalogue
//
//  Created by Yi JIANG on 25/10/18.
//  Copyright © 2018 Siphty. All rights reserved.
//

import Foundation

struct Catalogue: Codable {
    let category: String
    let items: [Item]
    
    struct Item: Codable {
        let title: String
        let year: Int
        let description: String
        let images: Image
        
        struct Image: Codable {
            let portrait: String
            let landscape: String
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                portrait = try container.decode(String.self, forKey: .portrait)
                landscape = try container.decode(String.self, forKey: .landscape)
            }
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            title = try container.decode(String.self, forKey: .title)
            year = try container.decode(Int.self, forKey: .year)
            description = try container.decode(String.self, forKey: .description)
            images = try container.decode(Image.self, forKey: .images)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        category = try container.decode(String.self, forKey: .category)
        items = try container.decode([Item].self, forKey: .items)
    }
}
