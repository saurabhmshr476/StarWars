//
//  Person.swift
//  StarWars
//
//  Created by SaurabhMishra on 06/09/20.
//  Copyright © 2020 SaurabhMishra. All rights reserved.
//

import Foundation


 struct PersonData: Codable {
     let count: Int
     let results: [Person]
}
 struct Person: Codable {

   let name: String
   let birthYear: String
   let eyeColor: String
   let gender: String
   let hairColor: String
   let height: String
   let mass: String
   let skinColor: String
   private let _homeworld: String
   let films: [String]
   private let _species: [String]
   private let _starships: [String]
   private let _vehicles: [String]
   let url: String
   let created: String
   let edited: String
  
  enum CodingKeys: String, CodingKey {
    case birthYear = "birth_year",
         name,
         mass,
         _vehicles = "vehicles",
         height
    case hairColor = "hair_color",
         skinColor = "skin_color",
         _starships = "starships"
    case created,
         eyeColor = "eye_color",
         gender,
         _homeworld = "homeworld",
         _species = "species"
    case url,
         edited,
         films = "films"
  }
}
