//
//  HeroDetailModel.swift
//  HeroRandomizerV2
//
//  Created by Alikhan Kassiman on 2025.03.25.
//

import Foundation

struct HeroDetailModel {
    let id: Int
    let name: String
    let fullName: String
    let imageUrl: URL?
    let race: String
    let publisher: String
    let alignment: String
    let base: String
    
    // Power stats
    let intelligence: Int
    let strength: Int
    let speed: Int
    let durability: Int
    let power: Int
    let combat: Int
}
