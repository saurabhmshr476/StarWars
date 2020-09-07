//
//  Flim.swift
//  StarWars
//
//  Created by SaurabhMishra on 07/09/20.
//  Copyright © 2020 SaurabhMishra. All rights reserved.
//

import Foundation
public struct Film: Codable{
    
    public let title: String
    public let openingCrawl: String
   
    enum CodingKeys: String, CodingKey {
      case openingCrawl = "opening_crawl",
           title
         
    }
}
