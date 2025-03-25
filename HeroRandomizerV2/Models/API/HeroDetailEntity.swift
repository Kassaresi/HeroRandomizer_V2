//
//  HeroDetailEntity.swift
//  HeroRandomizerV2
//
//  Created by Alikhan Kassiman on 2025.03.25.
//

import Foundation

struct HeroDetailEntity: Decodable {
    let id: Int
    let name: String
    let powerstats: PowerStats
    let appearance: Appearance
    let biography: Biography
    let work: Work
    let images: HeroImage
    
    var imageUrl: URL? {
        URL(string: images.md)
    }
    
    struct PowerStats: Decodable {
        let intelligence: Int
        let strength: Int
        let speed: Int
        let durability: Int
        let power: Int
        let combat: Int
    }
    
    struct Appearance: Decodable {
        let gender: String
        let race: String?
    }
    
    struct Biography: Decodable {
        let fullName: String
        let alignment: String
        let publisher: String?
    }
    
    struct Work: Decodable {
        let base: String
    }
    
    struct HeroImage: Decodable {
        let sm: String
        let md: String
    }
}
